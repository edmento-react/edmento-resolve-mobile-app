import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:edmentoresolve/features/student/presentation/bloc/student_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentTabs extends StatelessWidget {
  const StudentTabs({super.key, required this.students, required this.onTap});

  final List<String> students;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentCubit, int>(
      builder: (_, selectedIndex) {
        return Row(
          children: List.generate(students.length, (index) {
            final isSelected = index == selectedIndex;
            return Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: GestureDetector(
                onTap: () => onTap(index),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextWidget.heading3(context: context, students[index]),
                    const SizedBox(height: 4),
                    if (isSelected)
                      Container(
                        height: 2,
                        width: 28,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : ColorConstant.black,
                      ),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
