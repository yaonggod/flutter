import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project06/common/component/pagination_list_view.dart';
import 'package:project06/restaurant/provider/restaurant_provider.dart';
import 'package:project06/restaurant/component/restaurant_card.dart';
import 'package:project06/restaurant/view/restaurant_detail_screen.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginationListView(
        provider: restaurantProvider,
        itemBuilder: <RestaurantModel>(_, index, model) {
          return GestureDetector(
              onTap: () {
                context.goNamed(RestaurantDetailScreen.routeName, pathParameters: {'rid': model.id});
              },
              child: RestaurantCard.fromModel(
                restaurantModel: model,
                isDetail: false,
              ));
        });
  }
}

// return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//     child: ListView.separated(
//       controller: controller,
//       itemCount: cp.data.length + 1,
//       itemBuilder: (_, index) {
//         if (index == cp.data.length) {
//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Center(child: data is CursorPaginationFetchingMore ? CircularProgressIndicator() : Text("마지막 데이터입니다"),),
//           );
//         }
//         final pitem = cp.data[index] as RestaurantModel;
//         return GestureDetector(
//             onTap: () {
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                     builder: (_) => RestaurantDetailScreen(
//                         id: pitem.id, name: pitem.name)),
//               );
//             },
//             child: RestaurantCard.fromModel(restaurantModel: pitem, isDetail: false,));
//       },
//       separatorBuilder: (_, index) {
//         return SizedBox(
//           height: 16.0,
//         );
//       },
//     ));
//   Container(
//   child: Center(
//     child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         child: FutureBuilder<CursorPagination<RestaurantModel>>(
//           future: ref.watch(restaurantRepositoryProvider).paginate(),
//           builder: (context, AsyncSnapshot<CursorPagination<RestaurantModel>> snapshot) {
//             if (!snapshot.hasData) return Container();
//
//             return ListView.separated(
//                 itemBuilder: (_, index) {
//                   final pitem = snapshot.data!.data[index];
//                   return GestureDetector(
//                       onTap: () {
//                         Navigator.of(context).push(
//                             MaterialPageRoute(
//                                 builder: (_) => RestaurantDetailScreen(id: pitem.id, name: pitem.name)
//                             ),
//                         );
//                       },
//                       child: RestaurantCard.fromModel(
//                           restaurantModel: pitem));
//                 },
//                 separatorBuilder: (_, index) {
//                   return SizedBox(
//                     height: 16.0,
//                   );
//                 },
//                 itemCount: snapshot.data!.data.length);
//           },
//         )
// ),
//   ),
// );
