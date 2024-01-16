import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project06/common/const/colors.dart';
import 'package:project06/common/const/data.dart';
import 'package:project06/common/layout/default_layout.dart';
import 'package:project06/common/component/custom_text_form_field.dart';
import 'package:project06/common/provider/dio_provider.dart';
import 'package:project06/common/provider/secure_storage_provider.dart';
import 'package:project06/common/view/root_tab.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String username = '';
  String password = '';


  @override
  Widget build(BuildContext context) {
    final dio = ref.read(dioProvider);
    final storage = ref.read(secureStorageProvider);

    return DefaultLayout(
        child: SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: SafeArea(
        top: true,
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Title(),
              const SizedBox(height: 16.0),
              _SubTitle(),
              Image.asset(
                "asset/img/misc/logo.png",
                width: MediaQuery.of(context).size.width / 3 * 2,
              ),
              CustomTextFormField(
                hintText: '이메일을 입력해주세요',
                onChanged: (String value) {
                  setState(() {
                    username = value;
                  });
                },
              ),
              const SizedBox(
                height: 16.0,
              ),
              CustomTextFormField(
                hintText: '비밀번호를 입력해주세요',
                onChanged: (String value) {
                  setState(() {
                    password = value;
                  });
                },
                obscureText: true,
              ),
              const SizedBox(
                height: 16.0,
              ),
              ElevatedButton(
                onPressed: () async {
                  // ID 비밀번호 원본
                  final rawString = '$username:$password';
                  // final rawString = "test@codefactory.ai:testtest";

                  // Base64 인코딩
                  Codec<String, String> stringToBase64 = utf8.fuse(base64);
                  String token = stringToBase64.encode(rawString);

                  final path = "http://$ip/auth/login";

                  final response = await dio.post(path,
                      options:
                          Options(headers: {'authorization': 'Basic $token'}));

                  final refreshToken = response.data['refreshToken'];
                  final accessToken = response.data['accessToken'];

                  await storage.write(key: REFRESH_TOKEN_KEY, value: refreshToken);
                  await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => RootTab(),)
                  );
                },
                child: Text(
                  "로그인",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: PRIMARY_COLOR,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {

                },
                child: Text("회원가입"),
                style: TextButton.styleFrom(primary: PRIMARY_COLOR),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "환영합니다!",
      style: TextStyle(
          fontSize: 34, fontWeight: FontWeight.w500, color: Colors.black),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "이메일과 비밀번호를 입력해서 로그인해주세요!\n오늘도 성공적인 주문이 되길:)",
      style: TextStyle(fontSize: 16, color: BODY_TEXT_COLOR),
    );
  }
}
