import 'package:flutter/material.dart';
import 'package:study_ui_example/colors.dart';
import 'package:study_ui_example/common/layout/default_layout.dart';

import '../../common/component/custom_form_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PRIMARY_COLOR,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('로그인하슈'),
                ),
                TextButton(
                  onPressed: () {},
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
