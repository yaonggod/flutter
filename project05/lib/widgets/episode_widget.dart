import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:project05/models/webtoon_episode_model.dart';

class Episode extends StatelessWidget {
  const Episode({
    super.key,
    required this.e,
    required this.wid,
  });

  final WebtoonEpisodeModel e;
  final String wid;

  onButtonTap() async {
    await launchUrlString(
        "https://comic.naver.com/webtoon/detail?titleId=$wid&no=${e.id}");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.green.shade100,
            borderRadius: BorderRadius.circular(20)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(
              width: 220,
              height: 30,
              child: Text(e.title,
                  style: const TextStyle(
                      fontSize: 16, overflow: TextOverflow.ellipsis))),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.green.shade300,
            ),
          ),
        ]),
      ),
    );
  }
}
