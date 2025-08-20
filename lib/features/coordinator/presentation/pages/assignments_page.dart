import 'package:edmentoresolve/core/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class CoordinatorAssignmentsPage extends StatefulWidget {
  const CoordinatorAssignmentsPage({super.key});

  @override
  State<CoordinatorAssignmentsPage> createState() =>
      _CoordinatorAssignmentsPageState();
}

class _CoordinatorAssignmentsPageState
    extends State<CoordinatorAssignmentsPage> {
  Artboard? riveArtboard;
  SMIBool? isNight;

  @override
  void initState() {
    super.initState();
    rootBundle.load('assets/images/switcher.riv').then((data) async {
      try {
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;
        print('art board===============$artboard');
        var controller = StateMachineController.fromArtboard(artboard, 'SM');
        print('controller=============$controller');
        if (controller != null) {
          artboard.addController(controller);
          isNight = controller.findSMI('go');
          print('isNight------------$isNight');
        }
        setState(() {
          riveArtboard = artboard;
        });
      } catch (e) {
        print(e);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBarWidget(
        title: 'Assignments',
        actions: [
          isNight == null
              ? SizedBox()
              : Switch(
                  value: isNight!.value,
                  onChanged: (value) {
                    setState(() {
                      isNight!.value = value;
                    });
                  },
                ),
        ],
      ),
      body: riveArtboard == null
          ? SizedBox()
          : GestureDetector(
              onTap: () {
                isNight!.value = !isNight!.value;
              },
              child: Rive(artboard: riveArtboard!, fit: BoxFit.contain),
            ),
    );
  }
}
