import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_lv2/colors.dart';
import 'package:flutter_study_lv2/common/layout/default_layout.dart';

import '../../common/component/custom_form_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    final emulLocalhost = "10.0.2.2:3000";
    final simulLocalhost = "127.0.0.2:3000";

    final ip = Platform.isIOS ? simulLocalhost : emulLocalhost;

    return DefaultLayout(
      // SafeArea: 상단 상태바, 하단 네비게이션 바 등의 영역을 제외한 영역
      child: SingleChildScrollView(
        // 드래그 했을 때 키보드가 내려가는 옵션
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              // Column: 세로 방향으로 위젯을 배치
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Title(),
                const SizedBox(height: 16,),
                _Subtitle(),
                Image.asset(
                  'asset/img/misc/logo.png',
                  width: MediaQuery.of(context).size.width * (2/3),
                ),
                CustomTextFormField(
                  hintText: '이메일을 입력하슈..',
                  autofocus: true,
                  onChanged: (String value) {},
                ),
                const SizedBox(height: 16,),
                CustomTextFormField(
                  hintText: '비밀번호를 입력하슈..',
                  obscureText: true,
                  onChanged: (String value) {},
                ),
                const SizedBox(height: 16,),
                ElevatedButton(
                  onPressed: () async {
                    final rawString = "test@codefactory.ai:testtest";
                    Codec<String, String> stringToBase64 = utf8.fuse(base64);
                    final token = stringToBase64.encode(rawString);

                    final resp = await dio.post("http://$ip/auth/login",
                        options: Options(
                          headers: {
                            "Authorization": "Basic $token",
                          }
                        )
                    );

                    print(resp.data);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PRIMARY_COLOR,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('로그인하슈'),
                ),
                TextButton(
                  onPressed: () async {
                    final refreshtk = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3RAY29kZWZhY3RvcnkuYWkiLCJzdWIiOiJmNTViMzJkMi00ZDY4LTRjMWUtYTNjYS1kYTlkN2QwZDkyZTUiLCJ0eXBlIjoicmVmcmVzaCIsImlhdCI6MTY4OTg1NzcwNCwiZXhwIjoxNjg5OTQ0MTA0fQ.TMejlFItmVwYL0WGwWe8SfJMYc0yuV3ae-CM8f1AXTM";

                    final resp = await dio.post("http://$ip/auth/token",
                        options: Options(
                            headers: {
                              "authorization": "Bearer $refreshtk",
                            }
                        )
                    );

                    print(resp.data);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                  child: Text('회원가입하슈'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '환영합니다람쥐',
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        color: Colors.black
      )
    );
  }
}

class _Subtitle extends StatelessWidget {
  const _Subtitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '어서오시게나\n룰루리랄라리',
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: BODY_TEXT_COLOR
      )
    );
  }
}
