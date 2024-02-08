// pagination repository 인터페이스
import 'package:project06/common/model/cursor_pagination_model.dart';
import 'package:project06/common/model/model_with_id.dart';
import 'package:project06/common/model/pagination_params.dart';

abstract class IBasePaginationRepository<T extends IModelWithId> {
  Future<CursorPagination<T>> paginate({
    PaginationParams? paginationParams = const PaginationParams(),
  });
}
