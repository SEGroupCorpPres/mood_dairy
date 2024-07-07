import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color bgColor;
  final Color titleColor;
  final bool? isEmoSelect;

  const MainButton({
    super.key,
    required this.onPressed,
    required this.bgColor,
    required this.titleColor,
    this.isEmoSelect = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10).r,
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(30).r),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: onPressed,
            child: Text(
              'Сохранить',
              style: TextStyle(color: titleColor, fontSize: 17.sp),
            ),
          ),
        ],
      ),
    );
  }
}
