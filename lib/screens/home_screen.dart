import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mood_dairy/screens/change_status_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;
  DateTime currentDate = DateTime.now();
  List<DateTime?> _dates = [
    DateTime.now(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(length: 2, vsync: this);
    super.initState();
    tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tabController.dispose();
    super.dispose();
  }

  void _showCalendarBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: .95,
          minChildSize: .8,
          maxChildSize: 1.0,
          expand: true,
          builder: (_, controller) {
            return buildCalendar(context, controller);
          },
        );
      },
    );
  }

  Widget buildCalendar(BuildContext context, ScrollController controller) {
    return SingleChildScrollView(
      controller: controller,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0).r,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                 Text(
                  'Сегодня',
                  style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height - 100,
            child: CalendarDatePicker2(
              config: CalendarDatePicker2Config(
                calendarType: CalendarDatePicker2Type.single,
                calendarViewMode: CalendarDatePicker2Mode.scroll,
              ),
              value: _dates,
              onValueChanged: (dates) => _dates = dates,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    DateTime date = _dates.first ?? currentDate;
    initializeDateFormatting('ru', null);
    String formattedDate = DateFormat('d MMMM, HH:mm', 'ru').format(date);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          formattedDate,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => _showCalendarBottomSheet(context),
            icon: const Icon(
              Icons.calendar_month,
            ),
            iconSize: 18.sp,
            color: Colors.grey,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size(size.width, 45.h),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: Colors.blueGrey.withOpacity(.1),
              borderRadius: BorderRadius.circular(30).r,
            ),
            child: TabBar(
              padding: EdgeInsets.zero,
              indicatorColor: Colors.transparent,
              isScrollable: false,
              splashFactory: NoSplash.splashFactory,
              tabAlignment: TabAlignment.center,
              overlayColor: const WidgetStatePropertyAll<Color>(Colors.transparent),
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.white,
              labelPadding: EdgeInsets.zero,
              enableFeedback: false,
              dividerColor: Colors.white,
              controller: tabController,
              tabs: [
                Tab(
                  child: Container(
                    margin: EdgeInsets.zero,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15).r,
                    decoration: BoxDecoration(
                      color: tabController.index == 0 ? Colors.orange : Colors.transparent,
                      borderRadius: BorderRadius.circular(30).r,
                    ),
                    child: Row(
                      children: [Icon(Icons.content_paste), SizedBox(width: 7.w), Text('Дневник настроения')],
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    margin: EdgeInsets.zero,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15).r,
                    decoration: BoxDecoration(
                      color: tabController.index == 1 ? Colors.orange : Colors.transparent,
                      borderRadius: BorderRadius.circular(30).r,
                    ),
                    child: Row(
                      children: [Icon(Icons.bar_chart), SizedBox(width: 7.w), Text('Статистика')],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [
          ChangeStatusScreen(),
          Center(child: Text('Statistics')),
        ],
      ),
    );
  }
}
