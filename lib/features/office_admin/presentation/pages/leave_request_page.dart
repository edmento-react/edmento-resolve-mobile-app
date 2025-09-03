import 'package:edmentoresolve/core/widgets/index.dart';
import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class LeaveRequestPage extends StatelessWidget {
  const LeaveRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController reasonController = TextEditingController();
    DateTime? selectedDate;

    return Scaffold(
      appBar: AppBarWidget(title: 'Request Leave'),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget.heading4(
                'Leave Date',
                context: context,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 8),
              Builder(
                builder: (context) => InkWell(
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (picked != null) {
                      // setState would be used in StatefulWidget or via BLoC
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextWidget.body('Select date', context: context),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              TextWidget.heading4(
                'Reason',
                context: context,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: reasonController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter reason for leave',
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a reason'
                    : null,
                maxLines: 3,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // Submit leave request via BLoC
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: TextWidget.body('Leave request submitted!', context: context),
                        ),
                      );
                    }
                  },
                  child: TextWidget.label('Submit Request', context: context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
