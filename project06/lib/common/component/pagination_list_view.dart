import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project06/common/model/cursor_pagination_model.dart';
import 'package:project06/common/model/model_with_id.dart';
import 'package:project06/common/provider/pagination_provider.dart';
import 'package:project06/common/utils/pagination_utils.dart';

// context, index, model을 넣어서 Widget을 리턴하는 함수 정의
typedef PaginationWidgetBuilder<T extends IModelWithId> = Widget Function(
    BuildContext context, int index, T model);

class PaginationListView<T extends IModelWithId>
    extends ConsumerStatefulWidget {
  // provider를 받아와서 PaginationListView 내부에서 read해서 state의 원소를 itemBuilder에 넘겨줌
  final StateNotifierProvider<PaginationProvider, CursorPaginationBase> provider;
  // state의 index와 model을 기반으로 페이지에 맞는 Widget을 리턴하는 함수
  final PaginationWidgetBuilder<T> itemBuilder;

  const PaginationListView({required this.provider, required this.itemBuilder, super.key});

  @override
  ConsumerState<PaginationListView> createState() =>
      _PaginationListViewState<T>();
}

class _PaginationListViewState<T extends IModelWithId>
    extends ConsumerState<PaginationListView> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(listener);
  }

  @override
  void dispose() {
    controller.removeListener(listener);
    controller.dispose();
    super.dispose();
  }

  void listener() {
    PaginationUtils.paginate(
        controller: controller, provider: ref.read(widget.provider.notifier));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(widget.provider);

    // 첫 로딩
    if (state is CursorPaginationLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state is CursorPaginationError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(state.message),
            const SizedBox(
              height: 16.0,
            ),
            ElevatedButton(
                onPressed: () {
                  ref
                      .read(widget.provider.notifier)
                      .paginate(forceRefetch: true);
                },
                child: Text("재시도"))
          ],
        ),
      );
    }

    // state가 CursorPagination으로 들어온다고 지정 - refetching, fetchmore도 CursorPagination의 자식
    final cp = state as CursorPagination<T>;

    return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: RefreshIndicator(
            onRefresh: () async {
              ref.read(widget.provider.notifier).paginate(
                forceRefetch: true,
              );
            },
            child: ListView.separated(
              physics: AlwaysScrollableScrollPhysics(),
              controller: controller,
              itemCount: cp.data.length + 1,
              itemBuilder: (_, index) {
                if (index == cp.data.length) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: cp is CursorPaginationFetchingMore
                          ? CircularProgressIndicator()
                          : Text("마지막 데이터입니다"),
                    ),
                  );
                }
                final pitem = cp.data[index];
                return widget.itemBuilder(context, index, pitem);
              },
              separatorBuilder: (_, index) {
                return SizedBox(
                  height: 16.0,
                );
              },
            ),
          ),
    );
  }
}
