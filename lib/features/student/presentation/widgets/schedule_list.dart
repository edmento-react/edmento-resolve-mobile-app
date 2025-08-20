import 'package:edmentoresolve/features/student/presentation/widgets/schedule_tile.dart';
import 'package:flutter/material.dart';

class ScheduleList extends StatelessWidget {
  const ScheduleList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: List.generate(7, (i) => const ScheduleTile()));
  }
}
