import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project06/common/model/cursor_pagination_model.dart';
import 'package:project06/common/provider/pagination_provider.dart';
import 'package:project06/restaurant/model/restaurant_model.dart';
import 'package:project06/restaurant/provider/restaurant_repository_provider.dart';
import 'package:project06/restaurant/repository/restaurant_repository.dart';
import 'package:collection/collection.dart';

final restaurantDetailProvider =
    Provider.family<RestaurantModel?, String>((ref, id) {
  final state = ref.watch(restaurantProvider);

  if (state is! CursorPagination) return null;

  // id가 존재하지 않으면
  return state.data.firstWhereOrNull((element) => element.id == id);
});

final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>(
        (ref) => RestaurantStateNotifier(
            repository: ref.watch(restaurantRepositoryProvider)));

// 캐시로 관리하는 provider는 모두 StateNotifier로 - PaginationProvider가 StateNotifiter를 상속받음
class RestaurantStateNotifier extends PaginationProvider<RestaurantModel, RestaurantRepository> {

  RestaurantStateNotifier({required super.repository});

  void getDetail({ required String id, }) async {
    // 아직 데이터가 하나도 없는 상태
    if (state is! CursorPagination) {
      await this.paginate();
    }

    // pagination을 해도 CursorPagination이 아니면 ㅈㅈ
    if (state is! CursorPagination) {
      return;
    }

    // detail 가져오기
    final pState = state as CursorPagination;
    final response = await repository.getRestaurantDetail(id: id);

    // state 안의 RestaurantModel을 RestaurantDetailModel로 바꿔줌
    // 상세 페이지를 열어본 레스토랑만 detail을 갈아끼움
    // 존재하지 않는 데이터는? 그냥 리스트의 끝에다가 추가
    if (pState.data.where((e) => e.id == id).isEmpty) {
      state = pState.copyWith(
        data: <RestaurantModel>[...pState.data, response]
      );
    } else {
      state = pState.copyWith(
        data: pState.data.map<RestaurantModel>((e) => e.id == id ? response : e).toList(),
      );
    }
  }
}
