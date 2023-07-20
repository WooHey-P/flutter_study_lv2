import 'package:flutter/material.dart';

import '../../colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;

  const CustomTextFormField({
    this.hintText,
    this.errorText,
    this.obscureText = false,
    this.autofocus = false,
    required this.onChanged,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // UnderlineInputBorder: 밑줄
    // OutlineInputBorder: 외곽선
    final baseBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: INPUT_BORDER_COLOR,
        width: 1,
      ),
    );

    return TextFormField(
      cursorColor: PRIMARY_COLOR,
      // 비밀번호 입력 시 텍스트 숨김
      obscureText: obscureText,
      // 자동 포커스
      autofocus: autofocus,
      // 텍스트 변경 시 호출
      onChanged: onChanged,
      decoration: InputDecoration(
        // input 안의 패딩
        contentPadding: const EdgeInsets.all(20),
        // 힌트 텍스트
        hintText: hintText,
        errorText: errorText,
        hintStyle: const TextStyle(
          color: BODY_TEXT_COLOR,
          fontSize: 14,
        ),
        fillColor: INPUT_BG_COLOR,
        // false: 배경색 적용 안됨
        // true: 배경색 적용 됨
        filled: true,
        // 모든 input 상태의 기본 스타일 적용
        border: baseBorder,
        // enabled: false 일 때 적용되는 스타일
        enabledBorder: baseBorder,
        // focus 된 input 상태의 스타일 적용
        focusedBorder: baseBorder.copyWith(
          borderSide: baseBorder.borderSide.copyWith(
            color: PRIMARY_COLOR,
          )
        ),
      ),
    );
  }
}
