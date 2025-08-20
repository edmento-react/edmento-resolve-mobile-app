import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ScheduleTile extends StatelessWidget {
  const ScheduleTile({super.key});

  @override
  Widget build(BuildContext context) {
    final cardColor = Theme.of(context).cardColor;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(12),
            child: const Icon(Icons.menu_book_outlined, size: 28),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget.body(context: context, 'Math'),
              SizedBox(height: 4),
              TextWidget.body(context: context, '8:00 AM - 9:00 AM'),
            ],
          ),
        ],
      ),
    );
  }
}
