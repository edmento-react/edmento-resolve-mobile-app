import 'package:edmentoresolve/core/widgets/app_bar_widget.dart';
import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';

class StudentAssignmentsPage extends StatefulWidget {
  const StudentAssignmentsPage({super.key});

  @override
  State<StudentAssignmentsPage> createState() => _StudentAssignmentsPageState();
}

class _StudentAssignmentsPageState extends State<StudentAssignmentsPage> {
  String iosWidgetName = "MyHomeWidget";
  String androidWidgetName = "MyHomeWidget";
  String dataKey = "data_from_flutter_app";

  int assignment = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
        onPressed: () async {
          setState(() {
            assignment++;
          });

          String data = "$assignment";

          await HomeWidget.saveWidgetData(dataKey, data);

          await HomeWidget.updateWidget(
            iOSName: iosWidgetName,
            androidName: androidWidgetName,
          );
        },
        icon: Icon(Icons.add),
      ),
      appBar: AppBarWidget(title: 'Assignments'),
      body: Center(
        child: TextWidget.heading3(
          'Today Pending Assignments  = $assignment',
          context: context,
        ),
      ),
    );
  }
}
