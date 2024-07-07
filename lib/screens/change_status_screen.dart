import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mood_dairy/core/constats/emotion_list.dart';
import 'package:mood_dairy/model/emotion_menu_model.dart';
import 'package:mood_dairy/widgets/build_label.dart';
import 'package:mood_dairy/widgets/build_status.dart';
import 'package:mood_dairy/widgets/main_button.dart';

class ChangeStatusScreen extends StatefulWidget {
  const ChangeStatusScreen({super.key});

  @override
  State<ChangeStatusScreen> createState() => _ChangeStatusScreenState();
}

class _ChangeStatusScreenState extends State<ChangeStatusScreen> {
  final TextEditingController _noteController = TextEditingController();
  EmotionList emotions = EmotionList();
  double emotionStatus = 0;
  double selfAssessment = 0;
  bool isSelect = false;
  int? _selectedIndex;
  int? _selectedExtraEmoIndex;

  @override
  void initState() {
    super.initState();
  }

  void onTapEmotion(int index) {
    setState(() {
      if (_selectedIndex == index) {
        isSelect = false;
        _selectedIndex = null;
      } else {
        isSelect = true;
        _selectedIndex = index; // Tanlangan elementni yangilash
      }
    });
  }

  void onTapExtraEmo(int index) {
    setState(() {
      isSelect = true;
      _selectedExtraEmoIndex = index; // Tanlangan elementni yangilash
    });
  }

  void showSuccessDialog(BuildContext context) {
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return successAlertScreen(context);
      },
    );
  }

  Widget successAlertScreen(BuildContext context) {
    return AlertDialog.adaptive(
      icon: Platform.isIOS ? null : const Icon(Icons.check),
      content: const Text('Успешно сохранено'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Назад',
            style: TextStyle(
              color: Platform.isIOS ? CupertinoColors.activeBlue : Colors.orange,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20).r,
                  child: const BuildLabel(label: 'Что чувствуешь?'),
                ),
                SizedBox(
                  height: 130.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: emotions.emotionList().length,
                    itemBuilder: (context, item) {
                      EmotionMenuModel emotion = emotions.emotionList()[item];
                      return GestureDetector(
                        onTap: () => onTapEmotion(item),
                        child: AnimatedContainer(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50).r,
                            border: Border.all(
                              color: _selectedIndex == item ? Colors.orange : Colors.transparent,
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(.2),
                                offset: const Offset(0, 2),
                                spreadRadius: .3,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          width: 90.w,
                          height: 140.h,
                          margin: const EdgeInsets.only(left: 7, right: 7, top: 10, bottom: 10).r,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  emotion.image,
                                  width: 50.w,
                                  fit: BoxFit.cover,
                                ),
                                Text(
                                  emotion.title,
                                  style: TextStyle(fontSize: 11.sp),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: !isSelect ? 0 : 190.h,
                  curve: Curves.easeInOut,
                  width: !isSelect ? 0 : size.width,
                  padding: EdgeInsets.all(isSelect ? 20.0 : 0).r,
                  child: Wrap(
                    runSpacing: 7.h,
                    spacing: 7.w,
                    children: emotions.extraEmo().asMap().entries.map(
                      (entry) {
                        int index = entry.key;
                        String emotion = entry.value;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          height: 35.h,
                          curve: Curves.easeInOut,
                          decoration: BoxDecoration(
                            color: _selectedExtraEmoIndex == index ? Colors.orange : Colors.white,
                            borderRadius: BorderRadius.circular(20).r,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(.2),
                                offset: const Offset(0, 2),
                                spreadRadius: .2,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: TextButton(
                            style: TextButton.styleFrom(enableFeedback: false, splashFactory: NoSplash.splashFactory),
                            isSemanticButton: false,
                            onPressed: () => onTapExtraEmo(index),
                            child: Text(
                              emotion,
                              style: TextStyle(
                                color: _selectedExtraEmoIndex == index ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                )
              ],
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20).r,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BuildLabel(label: 'Уровень стресса'),
                        SizedBox(height: 10.h),
                        BuildStatus(
                          size: size,
                          minStatus: 'Низкий',
                          maxStatsus: 'Высокий',
                          statusValue: emotionStatus,
                          isSelectEmo: isSelect,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0).r,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BuildLabel(label: 'Самооценка'),
                        SizedBox(height: 10.h),
                        BuildStatus(
                          size: size,
                          statusValue: selfAssessment,
                          minStatus: 'Неуверенность',
                          maxStatsus: 'Уверенность',
                          isSelectEmo: isSelect,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0).r,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BuildLabel(label: 'Заметки'),
                        SizedBox(height: 10.h),
                        IgnorePointer(
                          ignoring: !isSelect,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10).r,
                            width: size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20).r,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(.2),
                                  offset: const Offset(0, 2),
                                  spreadRadius: .2,
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: TextField(
                              maxLines: 5,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Введите заметку',
                                hintStyle: const TextStyle(color: Colors.grey),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5).r,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            IgnorePointer(
              ignoring: !isSelect,
              child: MainButton(
                onPressed: () => showSuccessDialog(context),
                bgColor: isSelect ? Colors.orange : Colors.blueGrey.withOpacity(.2),
                titleColor: isSelect ? Colors.white : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
