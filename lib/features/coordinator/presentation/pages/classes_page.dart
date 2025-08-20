import 'package:edmentoresolve/core/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class CoordinatorClassesPage extends StatefulWidget {
  const CoordinatorClassesPage({super.key});

  @override
  State<CoordinatorClassesPage> createState() => _CoordinatorClassesPageState();
}

class _CoordinatorClassesPageState extends State<CoordinatorClassesPage> {
  Artboard? riveArtboard;
  SMIBool? isNight;

  @override
  void initState() {
    super.initState();
    rootBundle.load('assets/images/cimp.riv').then((data) async {
      try {
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;
        print('art board===============$artboard');
        var controller = StateMachineController.fromArtboard(artboard, 'Start');
        print('controller=============$controller');
        if (controller != null) {
          artboard.addController(controller);
          isNight = controller.findSMI('on/off');
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
        title: 'Classes',
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
          : Rive(artboard: riveArtboard!, fit: BoxFit.cover),
    );
  }
}
