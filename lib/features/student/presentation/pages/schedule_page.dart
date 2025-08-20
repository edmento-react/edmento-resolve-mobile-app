import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/schedule_cubit.dart';

class SchedulePage extends StatelessWidget {
  SchedulePage({super.key});

  final List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  final List<List<Map<String, dynamic>>> schedules = [
    // Monday Schedule
    [
      {
        'subject': 'Math',
        'time': '8:00 AM - 9:00 AM',
        'icon': Icons.menu_book_outlined,
      },
      {
        'subject': 'Science',
        'time': '9:00 AM - 10:00 AM',
        'icon': Icons.science_outlined,
      },
      {
        'subject': 'History',
        'time': '10:00 AM - 11:00 AM',
        'icon': Icons.public,
      },
      {'subject': 'English', 'time': '11:00 AM - 12:00 PM', 'icon': Icons.edit},
      {
        'subject': 'Lunch',
        'time': '12:00 PM - 1:00 PM',
        'icon': Icons.restaurant,
      },
      {
        'subject': 'Art',
        'time': '1:00 PM - 2:00 PM',
        'icon': Icons.color_lens_outlined,
      },
      {
        'subject': 'Physical Education',
        'time': '2:00 PM - 3:00 PM',
        'icon': Icons.sports_basketball_outlined,
      },
    ],
    // Tuesday Schedule (Sample)
    [
      {'subject': 'English', 'time': '8:00 AM - 9:00 AM', 'icon': Icons.edit},
      {
        'subject': 'Math',
        'time': '9:00 AM - 10:00 AM',
        'icon': Icons.menu_book_outlined,
      },
      {
        'subject': 'Chemistry',
        'time': '10:00 AM - 11:00 AM',
        'icon': Icons.science_outlined,
      },
    ],
    // Wednesday Schedule (Sample)
    [
      {
        'subject': 'Physics',
        'time': '8:00 AM - 9:00 AM',
        'icon': Icons.science_outlined,
      },
      {
        'subject': 'Biology',
        'time': '9:00 AM - 10:00 AM',
        'icon': Icons.bubble_chart,
      },
    ],
    [
      {
        'subject': 'Math',
        'time': '8:00 AM - 9:00 AM',
        'icon': Icons.menu_book_outlined,
      },
      {
        'subject': 'Science',
        'time': '9:00 AM - 10:00 AM',
        'icon': Icons.science_outlined,
      },
      {
        'subject': 'History',
        'time': '10:00 AM - 11:00 AM',
        'icon': Icons.public,
      },
      {'subject': 'English', 'time': '11:00 AM - 12:00 PM', 'icon': Icons.edit},
      {
        'subject': 'Lunch',
        'time': '12:00 PM - 1:00 PM',
        'icon': Icons.restaurant,
      },
      {
        'subject': 'Art',
        'time': '1:00 PM - 2:00 PM',
        'icon': Icons.color_lens_outlined,
      },
      {
        'subject': 'Physical Education',
        'time': '2:00 PM - 3:00 PM',
        'icon': Icons.sports_basketball_outlined,
      },
    ],
    [
      {
        'subject': 'Math',
        'time': '8:00 AM - 9:00 AM',
        'icon': Icons.menu_book_outlined,
      },
      {
        'subject': 'Science',
        'time': '9:00 AM - 10:00 AM',
        'icon': Icons.science_outlined,
      },
      {
        'subject': 'History',
        'time': '10:00 AM - 11:00 AM',
        'icon': Icons.public,
      },
      {'subject': 'English', 'time': '11:00 AM - 12:00 PM', 'icon': Icons.edit},
      {
        'subject': 'Lunch',
        'time': '12:00 PM - 1:00 PM',
        'icon': Icons.restaurant,
      },
      {
        'subject': 'Art',
        'time': '1:00 PM - 2:00 PM',
        'icon': Icons.color_lens_outlined,
      },
      {
        'subject': 'Physical Education',
        'time': '2:00 PM - 3:00 PM',
        'icon': Icons.sports_basketball_outlined,
      },
    ],
    [
      {
        'subject': 'Math',
        'time': '8:00 AM - 9:00 AM',
        'icon': Icons.menu_book_outlined,
      },
      {
        'subject': 'Science',
        'time': '9:00 AM - 10:00 AM',
        'icon': Icons.science_outlined,
      },
      {
        'subject': 'History',
        'time': '10:00 AM - 11:00 AM',
        'icon': Icons.public,
      },
      {'subject': 'English', 'time': '11:00 AM - 12:00 PM', 'icon': Icons.edit},
      {
        'subject': 'Lunch',
        'time': '12:00 PM - 1:00 PM',
        'icon': Icons.restaurant,
      },
      {
        'subject': 'Art',
        'time': '1:00 PM - 2:00 PM',
        'icon': Icons.color_lens_outlined,
      },
      {
        'subject': 'Physical Education',
        'time': '2:00 PM - 3:00 PM',
        'icon': Icons.sports_basketball_outlined,
      },
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ScheduleCubit(),
      child: Scaffold(
        appBar: AppBarWidget(
          title: 'Schedule',
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          foregroundColor: Theme.of(context).textTheme.bodyLarge!.color!,
        ),
        body: _SchedulePageView(weekdays: weekdays, schedules: schedules),
      ),
    );
  }
}

class _SchedulePageView extends StatefulWidget {
  final List<String> weekdays;
  final List<List<Map<String, dynamic>>> schedules;
  const _SchedulePageView({required this.weekdays, required this.schedules});

  @override
  State<_SchedulePageView> createState() => _SchedulePageViewState();
}

class _SchedulePageViewState extends State<_SchedulePageView> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    final selectedIndex = context.read<ScheduleCubit>().state;
    _pageController = PageController(initialPage: selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDaySelector(),
        const Divider(height: 1),
        Expanded(
          child: BlocBuilder<ScheduleCubit, int>(
            builder: (context, selectedIndex) {
              return PageView.builder(
                controller: _pageController,
                itemCount: widget.weekdays.length,
                onPageChanged: (index) {
                  context.read<ScheduleCubit>().selectDay(index);
                },
                itemBuilder: (context, index) {
                  final items = widget.schedules[index];
                  return ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (_, i) {
                      final item = items[i];
                      return Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color:
                                  Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? ColorConstant.grey800
                                  : ColorConstant.grey200,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(item['icon'], size: 28),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['subject'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item['time'],
                                style: TextStyle(
                                  color:
                                      Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? ColorConstant.grey400
                                      : ColorConstant.grey600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDaySelector() {
    return BlocBuilder<ScheduleCubit, int>(
      builder: (context, selectedIndex) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: List.generate(widget.weekdays.length, (index) {
              final isSelected = selectedIndex == index;
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: GestureDetector(
                  onTap: () {
                    context.read<ScheduleCubit>().selectDay(index);
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.weekdays[index],
                        style: TextStyle(
                          fontSize: 16,
                          color: isSelected
                              ? (Theme.of(context).brightness == Brightness.dark
                                    ? ColorConstant.white
                                    : ColorConstant.black)
                              : (Theme.of(context).brightness == Brightness.dark
                                    ? ColorConstant.grey400
                                    : ColorConstant.grey600),
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (isSelected)
                        Container(
                          height: 2,
                          width: 28,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? ColorConstant.white
                              : ColorConstant.black,
                        ),
                    ],
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
