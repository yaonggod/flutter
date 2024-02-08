import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project06/common/model/cursor_pagination_model.dart';
import 'package:project06/common/model/model_with_id.dart';
import 'package:project06/common/model/pagination_params.dart';
import 'package:project06/common/repository/base_pagination_repository.dart';

class _PaginationInfo {
  final int fetchCount;
  // false = 새로고침(현재 상태를 덮어씌움), true = 추가로 데이터 더 가져옴
  final bool fetchMore;
  // 강제로 재로딩 - true - CursorPaginationLoading() / false - 화면의 데이터를 지우고 로딩
  final bool forceRefetch;
  _PaginationInfo({ this.fetchCount = 20, this.fetchMore = false, this.forceRefetch = false });
}

class PaginationProvider<T extends IModelWithId,
        U extends IBasePaginationRepository<T>>
    extends StateNotifier<CursorPaginationBase> {
  final U repository;

  // 명령이 처음에 들어가고 1초동안 똑같은 함수가 실행되는 것을 막음
  final paginationThrottle = Throttle(Duration(seconds: 3), initialValue: _PaginationInfo(), checkEquality: false);

  // 처음에는 로딩중 상태로 뒀다가
  // 처음 인스턴스를 생성할 때 repository를 가지고 paginate해줭 -> CursorPagination으로
  PaginationProvider({required this.repository})
      : super(CursorPaginationLoading()) {
    paginate();
    paginationThrottle.values.listen((event) {
      _throttledPagination(event);
    });
  }

  Future<void> paginate({
    int fetchCount = 20,
    // false = 새로고침(현재 상태를 덮어씌움), true = 추가로 데이터 더 가져옴
    bool fetchMore = false,
    // 강제로 재로딩 - true - CursorPaginationLoading() / false - 화면의 데이터를 지우고 로딩
    bool forceRefetch = false,
  }) async {
    paginationThrottle.setValue(_PaginationInfo(
      fetchMore: fetchMore,
      fetchCount: fetchCount,
      forceRefetch: forceRefetch
    ));
  }

  _throttledPagination(_PaginationInfo info) async {
    final fetchCount = info.fetchCount;
    final forceRefetch = info.forceRefetch;
    final fetchMore = info.fetchMore;
    try {
      // state에 따라서
      // 1. CursorPagination - 정상적으로 데이터가 있는 상태
      // 2. CursorPaginationLoading - 데이터 로딩중, 현재 캐시 없음 == (forceRefetch == true)
      // 3. CursorPaginationError
      // 4. CursorPaginationRefetching - 첫 번째 데이터부터 데이터를 다시 가져옴
      // 5. CursorPaginationFetchMore - 추가로 데이터를 paginate

      // 바로 반환하는 상황
      // 1. hasMore == false (= 마지막 페이지까지 불러온 적이 있다 == 더 불러올 데이터가 없음)
      // 2-1. 로딩중 && fetchMore == true (= 더 데이터를 가져와 주세요 요청을 보냈는데 응답을 기다리고 있는데 똑같은 요청을 보냈음)
      // 2-2. 로딩중 && fetchMore == false (= 더 데이터를 가져와 달라고 요청을 보냈는데 위로 스크롤해서 가져올 필요가 없어짐)

      // CursorPagination 해서 state에 데이터가 있고, 강제 새로고침 요청이 아님
      if (state is CursorPagination && !forceRefetch) {
        final pState = state as CursorPagination;
        // 1. !hasMore (마지막 데이터까지 불러왔음)
        if (!pState.meta.hasMore) {
          // paginate를 해서 state를 바꿀 필요가 없음
          return;
        }
      }

      // 첫 로딩
      final isLoading = state is CursorPaginationLoading;
      // 데이터는 있으나 새로고침
      final isRefetching = state is CursorPaginationRefetching;
      // 데이터 있고 추가 요청
      final isFetchingMore = state is CursorPaginationFetchingMore;

      // 데이터 더 달라고 했지만 로딩중이다
      if (fetchMore && (isLoading || isRefetching || isFetchingMore)) {
        // 아무것도 안한다
        return;
      }

      // PaginationParams - pagination 시 마지막 데이터 id와 요청 갯수
      PaginationParams paginationParams = PaginationParams(count: fetchCount);

      // fetchMore == true 데이터 더줭
      if (fetchMore) {
        final pState = state as CursorPagination<T>;

        // state를 fetchingMore로 바꿔주기
        state = CursorPaginationFetchingMore<T>(
            meta: pState.meta, data: pState.data);

        // 데이터의 마지막 item의 id 넣어주기 - T는 IModelWithId라 무조건 id 존재
        paginationParams = paginationParams.copyWith(
          after: pState.data.last.id,
        );
        // 데이터를 처음부터 가져오는 상황 - paginationParams를 바꿀 필요가 없음
      } else {
        // 근데 기존 데이터가 있음
        if (state is CursorPagination && !forceRefetch) {
          final pState = state as CursorPagination<T>;
          // 데이터는 있는데 새로고침하고 있다
          state = CursorPaginationRefetching<T>(
              meta: pState.meta, data: pState.data);
        } else {
          state = CursorPaginationLoading();
        }
      }

      // 요청을 보내기
      final response =
          await repository.paginate(paginationParams: paginationParams);

      // 추가 데이터에 대한 응답이 왔으니까 state를 바꿔주기
      if (state is CursorPaginationFetchingMore) {
        final pState = state as CursorPaginationFetchingMore<T>;

        // 응답으로 온 data + 기존에 있던 data
        state = response.copyWith(
          data: [...pState.data, ...response.data],
        );
        // 데이터 추가 ㄴㄴ
      } else {
        state = response;
      }
    } catch (err) {
      state = CursorPaginationError(message: err.toString());
    }
  }
}
