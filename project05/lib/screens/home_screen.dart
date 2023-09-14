import 'package:flutter/material.dart';
import 'package:project05/models/webtoon_model.dart';
import 'package:project05/services/api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // Future랑 const Class는 상충함, 컴파일 전에 값을 알 수 없음
  // state로 webtoons와 isLoading 상태를 관리할 필요 없이 Future로 stateless하게 만들기
  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green.shade50,
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          foregroundColor: Colors.green.shade300,
          title: const Text(
            "Today's 툰s",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: FutureBuilder(
          future: webtoons,
          builder: (context, snapshot) {
            // Future의 상태를 알려줌
            if (snapshot.hasData) {
              // 최적화된 ListView, 아이템을 모두 순회해서 위젯을 한번에 리턴하는 대신
              // 화면에 필요한 인덱스마다 하나씩 build함
              // return ListView.builder(
              //   scrollDirection: Axis.vertical,
              //   itemCount: snapshot.data!.length,
              //   itemBuilder: (context, index) {
              //     var webtoon = snapshot.data![index];
              //     return Text(webtoon.title);
              //   },
              // );
              return Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Expanded(
                    child: makeList(snapshot),
                  ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        return Column(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    offset: const Offset(10, 0),
                    color: Colors.black.withOpacity(0.5),
                  )
                ],
              ),
              width: 250,
              child: Image.network(webtoon.thumb, headers: const {
                "User-Agent":
                    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36",
              }),
            ),
            Text(
              webtoon.title,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        );
      },
      // 분리
      separatorBuilder: (context, index) {
        return const SizedBox(
          width: 40,
        );
      },
      itemCount: snapshot.data!.length,
      scrollDirection: Axis.horizontal,
    );
  }
}
