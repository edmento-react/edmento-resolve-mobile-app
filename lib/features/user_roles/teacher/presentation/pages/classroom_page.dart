import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/constants/padding_constant.dart';
import 'package:edmentoresolve/core/constants/style_constant.dart';
import 'package:edmentoresolve/core/widgets/index.dart';
import 'package:edmentoresolve/core/widgets/layout/tab_bar_widget.dart';
import 'package:edmentoresolve/features/user_roles/teacher/domain/entities/resource_model.dart';
import 'package:flutter/material.dart';

class ClassroomPage extends StatefulWidget {
  const ClassroomPage({super.key});

  @override
  State<ClassroomPage> createState() => _ClassroomPageState();
}

class _ClassroomPageState extends State<ClassroomPage>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;

  final List<String> _tabs = [
    "10 A",
    "10 B",
    "10 C",
    "9 A",
    "9 B",
    "9 C",
    "8 C",
    "8 A",
    "8 B",
  ];

  final List<List<Resource>> tabResources = [
    // Tab 0 -> 10 A
    [
      const Resource(title: "Motion.pdf"),
      const Resource(title: "Newton's Laws.ppt"),
      const Resource(title: "Experiment Video.mp4"),
    ],
    // Tab 1 -> 10 B
    [
      const Resource(title: "Work and Energy.pdf"),
      const Resource(title: "Power.ppt"),
      const Resource(title: "Lab Demo.mp4"),
    ],
    // Tab 2 -> 10 C
    [
      const Resource(title: "Gravitation.pdf"),
      const Resource(title: "Planetary Motion.ppt"),
      const Resource(title: "Experiment Video.mp4"),
    ],
    // Tab 3 -> 9 A
    [
      const Resource(title: "Algebra of Vectors.pdf"),
      const Resource(title: "Equations of Motion.ppt"),
      const Resource(title: "Problem Solving.mp4"),
    ],
    // Tab 4 -> 9 B
    [
      const Resource(title: "Heat.pdf"),
      const Resource(title: "Thermodynamics.ppt"),
      const Resource(title: "Practical Demo.mp4"),
    ],
    // Tab 5 -> 9 C
    [
      const Resource(title: "Light.pdf"),
      const Resource(title: "Reflection and Refraction.ppt"),
      const Resource(title: "Experiment Video.mp4"),
    ],
    // Tab 6 -> 8 C
    [
      const Resource(title: "Sound.pdf"),
      const Resource(title: "Waves.ppt"),
      const Resource(title: "Lab Experiment.mp4"),
    ],
    [
      const Resource(title: "Sound.pdf"),
      const Resource(title: "Waves.ppt"),
      const Resource(title: "Lab Experiment.mp4"),
    ],
    [
      const Resource(title: "Sound.pdf"),
      const Resource(title: "Waves.ppt"),
      const Resource(title: "Lab Experiment.mp4"),
    ],
  ];

  @override
  void initState() {
    _controller = TabController(length: _tabs.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: ElevatedButton.icon(
      //   style: ButtonStyle(),
      //   onPressed: () {},
      //   icon: Icon(Icons.tv),
      //   label: TextWidget.body(
      //     'Connect to TV',
      //     context: context,
      //     color: ColorConstant.white,
      //   ),
      // ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: ColorConstant.primaryLight.withOpacity(0.5),
              blurRadius: 5,
              spreadRadius: 1,
              offset: Offset(2, 3),
            ),
          ],
          // gradient: ColorConstant.appGradient,
          color: ColorConstant.primaryLight,
          borderRadius: BorderRadius.circular(10),
        ),

        child: ButtonWidget.text(
          icon: Icons.tv,
          textStyle: StyleConstant.body(
            context,
          ).copyWith(color: ColorConstant.white, fontWeight: FontWeight.w600),
          label: 'Connect to TV',
          onPressed: () {},
          context: context,
        ),
      ),
      appBar: AppBarWidget(title: 'Classroom', centerTitle: false),
      body: Column(
        children: [
          AppTabBar.solid(
            tabs: _tabs,
            controller: _controller,
            indicatorColor: colorScheme.onSurface,
          ),
          Expanded(
            child: TabBarView(
              controller: _controller,
              children: List.generate(
                _tabs.length,
                (index) =>
                    _buildTopicList(context, tabResources[index], colorScheme),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopicList(
    BuildContext context,
    List<Resource> resources,
    ColorScheme colorScheme,
  ) {
    return Padding(
      padding: PaddingConstant.cardPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget.heading3("Today's Topic", context: context),
          SpacerWidget.medium(),
          ...resources.map(
            (res) => Card(
              margin: PaddingConstant.itemMargin,
              elevation: PaddingConstant.cardElevation,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  PaddingConstant.borderRadius,
                ),
                side: BorderSide(color: colorScheme.outline),
              ),
              child: ListTile(
                title: TextWidget.body(res.title, context: context),
                trailing: const Icon(Icons.visibility),
                onTap: () {
                  // Handle file tap
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
