import 'package:badges/badges.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project06/common/const/colors.dart';
import 'package:project06/common/layout/default_layout.dart';
import 'package:project06/common/model/cursor_pagination_model.dart';
import 'package:project06/common/utils/pagination_utils.dart';
import 'package:project06/product/model/product_model.dart';
import 'package:project06/rating/component/rating_card.dart';
import 'package:project06/rating/model/rating_model.dart';
import 'package:project06/rating/provider/rating_provider.dart';
import 'package:project06/restaurant/provider/restaurant_provider.dart';
import 'package:project06/product/component/product_card.dart';
import 'package:project06/product/model/restaurant_product_model.dart';
import 'package:project06/restaurant/component/restaurant_card.dart';
import 'package:project06/restaurant/model/restaurant_detail_model.dart';
import 'package:project06/restaurant/model/restaurant_model.dart';
import 'package:project06/restaurant/view/basket_screen.dart';
import 'package:project06/user/provider/basket_provider.dart';
import 'package:skeletons/skeletons.dart';

class RestaurantDetailScreen extends ConsumerStatefulWidget {
  static String get routeName => "restaurantDetail";
  final String id;

  const RestaurantDetailScreen({required this.id, super.key});

  @override
  ConsumerState<RestaurantDetailScreen> createState() =>
      _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState
    extends ConsumerState<RestaurantDetailScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    ref.read(restaurantProvider.notifier).getDetail(id: widget.id);
    controller.addListener(() {
      PaginationUtils.paginate(controller: controller,
          provider: ref.read(ratingProvider(widget.id).notifier));
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(restaurantDetailProvider(widget.id));
    final ratingsState = ref.watch(ratingProvider(widget.id));
    final basket = ref.watch(basketProvider);

    int totalRating = 0;
    double averageRating = 0;
    if (ratingsState is CursorPagination<RatingModel>) {
      for (int i = 0; i < ratingsState.data.length; i++) {
        totalRating += ratingsState.data[i].rating;
      }
      averageRating = totalRating / ratingsState.data.length;
    }

    if (state == null)
      return DefaultLayout(
          child: Center(
            child: CircularProgressIndicator(),
          ));

    return DefaultLayout(
        title: state.name,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.pushNamed(BasketScreen.routeName);
          },
          backgroundColor: PRIMARY_COLOR,
          foregroundColor: Colors.white,
          child: Badge(
            showBadge: basket.isNotEmpty,
            badgeContent: Text(
              basket.fold<int>(0, (prev, next) => prev + next.count).toString(),
              style: TextStyle(color: PRIMARY_COLOR, fontSize: 10.0),
            ),
            child: Icon(Icons.shopping_basket_outlined),
            badgeStyle: BadgeStyle(badgeColor: Colors.white),
          ),
        ),
        child: CustomScrollView(
          controller: controller,
          slivers: [
            renderTop(restaurantModel: state),
            if (state is! RestaurantDetailModel) renderLoading(),
            if (state is RestaurantDetailModel) renderLabel("메뉴"),
            if (state is RestaurantDetailModel)
              renderProducts(products: state.products, restaurant: state),
            SliverToBoxAdapter(
              child: SizedBox(height: 8.0,),
            ),
            if (state is RestaurantDetailModel &&
                ratingsState is CursorPagination<RatingModel>) renderLabel(
                "리뷰 ($averageRating/5)"),
            if (state is RestaurantDetailModel &&
                ratingsState is CursorPagination<RatingModel>)
              renderRatings(ratings: ratingsState.data),
          ],
        ));
  }

  SliverPadding renderLoading() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      sliver: SliverList(
        delegate: SliverChildListDelegate(List.generate(
            3,
                (index) =>
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: SkeletonParagraph(
                    style: SkeletonParagraphStyle(
                        lines: 5, padding: EdgeInsets.zero),
                  ),
                ))),
      ),
    );
  }

  SliverToBoxAdapter renderTop({required RestaurantModel restaurantModel}) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(
        restaurantModel: restaurantModel,
        isDetail: true,
      ),
    );
  }

  SliverPadding renderProducts(
      {required List<RestaurantProductModel> products, required RestaurantModel restaurant }) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final model = products[index];
          // 클릭 효과
          return InkWell(
            onTap: () {
              ref.read(basketProvider.notifier).addToBasket(
                  product: ProductModel(id: model.id,
                      name: model.name,
                      detail: model.detail,
                      imgUrl: model.imgUrl,
                      price: model.price,
                      restaurant: restaurant));
            },
            child: Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
              ),
              child: ProductCard.fromRestaurantProductModel(model: model),
            ),
          );
        }, childCount: products.length),
      ),
    );
  }

  SliverPadding renderRatings({required List<RatingModel> ratings}) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final model = ratings[index];
          return Padding(
            padding: const EdgeInsets.only(
              top: 16.0,
            ),
            child: RatingCard.fromModel(ratingModel: model),
          );
        }, childCount: ratings.length),
      ),
    );
  }


  SliverToBoxAdapter renderLabel(String label) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0,),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}


