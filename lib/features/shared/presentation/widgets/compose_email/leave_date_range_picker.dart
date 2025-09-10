import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LeaveDateRangePicker extends StatelessWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final Function(DateTime?) onStartDateChanged;
  final Function(DateTime?) onEndDateChanged;

  const LeaveDateRangePicker({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.onStartDateChanged,
    required this.onEndDateChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row(
          //   children: [
          //     Icon(
          //       Icons.calendar_today,
          //       size: 20,
          //       color: Theme.of(context).colorScheme.primary,
          //     ),
          //     const SizedBox(width: 8),
          //     Text(
          //       'Leave Period',
          //       style: Theme.of(context).textTheme.titleSmall?.copyWith(
          //         fontWeight: FontWeight.w600,
          //         color: Theme.of(context).colorScheme.onSurface,
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 16),
          InkWell(
            onTap: () => _selectDateRange(context),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(
                    context,
                  ).colorScheme.outline.withValues(alpha: 0.3),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      (startDate != null && endDate != null)
                          ? (startDate == endDate)
                                ? DateFormat('MMM dd, yyyy').format(startDate!)
                                : '${DateFormat('MMM dd, yyyy').format(startDate!)} → ${DateFormat('MMM dd, yyyy').format(endDate!)}'
                          : 'Select leave period',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: (startDate != null && endDate != null)
                            ? Theme.of(context).colorScheme.onSurface
                            : Theme.of(
                                context,
                              ).colorScheme.onSurface.withValues(alpha: 0.5),
                        fontWeight: (startDate != null && endDate != null)
                            ? FontWeight.w500
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.calendar_month,
                    size: 18,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ),
          ),
          if (startDate != null && endDate != null) ...[
            const SizedBox(height: 12),
            _buildDurationInfo(context),
          ],
        ],
      ),
    );
  }

  Widget _buildDurationInfo(BuildContext context) {
    if (startDate == null || endDate == null) return const SizedBox.shrink();

    final duration = endDate!.difference(startDate!).inDays + 1;
    final isInvalid = endDate!.isBefore(startDate!);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isInvalid
            ? Theme.of(
                context,
              ).colorScheme.errorContainer.withValues(alpha: 0.1)
            : Theme.of(
                context,
              ).colorScheme.primaryContainer.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isInvalid
              ? Theme.of(context).colorScheme.error.withValues(alpha: 0.3)
              : Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            isInvalid ? Icons.warning : Icons.info,
            size: 16,
            color: isInvalid
                ? Theme.of(context).colorScheme.error
                : Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              isInvalid
                  ? 'End date cannot be before start date'
                  : 'Total leave duration: $duration day${duration > 1 ? 's' : ''}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isInvalid
                    ? Theme.of(context).colorScheme.error
                    : Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final values = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        calendarType: CalendarDatePicker2Type.range,
      ),
      dialogSize: const Size(325, 400),
      borderRadius: BorderRadius.circular(15),
      value: [startDate, endDate],
    );

    if (values != null && values.isNotEmpty) {
      final pickedStart = values[0];
      DateTime? pickedEnd = values.length > 1
          ? values[1]
          : null; // May be null if only one date

      if (pickedStart != null) {
        onStartDateChanged(pickedStart);
        pickedEnd ??= pickedStart;
        onEndDateChanged(pickedEnd);
      }
    }
  }
}
