import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildStatus extends StatefulWidget {
  final Size? size;
  final String minStatus;
  final String maxStatsus;
  final double statusValue;
  final bool isSelectEmo;

  const BuildStatus({
    super.key,
    this.size,
    required this.minStatus,
    required this.maxStatsus,
    required this.statusValue,
    this.isSelectEmo = false,
  });

  @override
  State<BuildStatus> createState() => _BuildStatusState();
}

class _BuildStatusState extends State<BuildStatus> {
  late double statusValue;

  void _changeValue(double value) {
    statusValue = value;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    statusValue = widget.statusValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(vertical: 10.h),
      width: widget.size!.width,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5).r,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                5,
                (item) => Container(
                  height: 8.h,
                  width: 2,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          IgnorePointer(
            ignoring: !widget.isSelectEmo,
            child: Slider.adaptive(
              activeColor: Colors.orange,
              min: 0,
              max: 10,
              label: 'emotion status',
              value: statusValue,
              onChanged: (value) => _changeValue(value),
              allowedInteraction: SliderInteraction.tapAndSlide,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5).r,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.minStatus,
                  style:  TextStyle(color: Colors.grey, fontSize: 12.sp),
                ),
                Text(
                  widget.maxStatsus,
                  style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
