import 'package:flutter/cupertino.dart';
import 'package:project06/common/provider/pagination_provider.dart';

class PaginationUtils {
  static void paginate({ required ScrollController controller, required PaginationProvider provider }) {
    // 현재 위치가 최대 길이보다 덜 되는 위치라면 데이터 추가 요청
    if (controller.offset > controller.position.maxScrollExtent - 300) {
      provider.paginate(fetchMore: true);
    }
  }
}