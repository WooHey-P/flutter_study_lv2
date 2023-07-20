import 'package:flutter/material.dart';
import 'package:flutter_study_lv2/user/view/login_screen.dart';

void main() {
  runApp(
    _App()
  );
}

// private 에는 underscore(_)를 붙인다.
class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotoSans'
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
