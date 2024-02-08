import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project06/common/model/cursor_pagination_model.dart';
import 'package:project06/common/provider/pagination_provider.dart';
import 'package:project06/rating/model/rating_model.dart';
import 'package:project06/rating/provider/rating_repository_provider.dart';
import 'package:project06/rating/repository/rating_repository.dart';

final ratingProvider = StateNotifierProvider.family<RatingStateNotifier, CursorPaginationBase, String>((ref, id) {
  final repository = ref.watch(ratingRepositoryProvider(id));
  return RatingStateNotifier(repository: repository);
});

class RatingStateNotifier extends PaginationProvider<RatingModel, RatingRepository> {
  RatingStateNotifier({ required super.repository });
}