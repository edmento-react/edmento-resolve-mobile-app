import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/constants/padding_constant.dart';
import 'package:edmentoresolve/core/config/routes.dart';
import 'package:edmentoresolve/core/widgets/cards/glass_container.dart';
import 'package:edmentoresolve/core/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class TeacherHomePage extends StatelessWidget {
  const TeacherHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBarWidget(
        centerTitle: false,
        // leading: CircleAvatar(),
        title: 'Hello, 👋\nVenugobalan!',

        // titleWidget: Row(
        //   children: [
        //     GestureDetector(
        //       onTap: () {
        //         context.push(AppRoutes.profile);
        //       },
        //       child: CircleAvatar(
        //         // radius: 20,
        //         backgroundImage: AssetImage('assets/images/profile.jpg'),
        //       ),
        //     ),
        //     SpacerWidget.widthLarge(),
        //     // TextWidget.heading3(context: context, 'Hello, 👋\nVenugobalan!'),
        //   ],
        // ),
        leading: GestureDetector(
          onTap: () {
            context.push(AppRoutes.profile);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: CircleAvatar(
              radius: 10,
              backgroundImage: AssetImage('assets/images/profile.jpg'),
            ),
          ),
        ),

        actions: [
          // IconButton(
          //   icon: Icon(
          //     Icons.notifications,
          //     color: isDark ? ColorConstant.white : ColorConstant.black,
          //   ),
          //   onPressed: () {
          //     // TODO: Navigate to notifications
          //   },
          // ),
          GestureDetector(
            onTap: () {
              context.push(AppRoutes.notifications);
            },
            child: GlassContainer(
              width: 45,
              height: 45,
              borderRadius: 30,
              child: const Icon(Icons.notifications_none_rounded),
            ),
          ),

          // LiquidGlass(
          //   shape: LiquidRoundedSuperellipse(borderRadius: Radius.circular(50)),
          //   child: const SizedBox(
          //     height: 60,
          //     width: 60,
          //     child: Center(child: Icon(Icons.notifications_active)),
          //   ),
          // ),
        ],
      ),
      body: SingleChildScrollView(
        padding: PaddingConstant.screenPaddingReduced,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Welcome Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget.heading4('My Class- 10 B', context: context),
                SpacerWidget.large(),
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 7.w,
                    mainAxisSpacing: 7.h,
                    childAspectRatio: 0.6,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: gridItems.length,
                  itemBuilder: (context, index) {
                    final item = gridItems[index];
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () => context.push(item.pageName),
                          child: Container(
                            width: 70.w,
                            height: 70.h,
                            decoration: BoxDecoration(
                              color: ColorConstant.primaryLight.withOpacity(.1),
                              border: Border.all(
                                color: ColorConstant.primaryLight.withOpacity(
                                  .5,
                                ),
                              ),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Icon(
                              item.icon,
                              size: 24.w,
                              color: ColorConstant.primaryLight,
                            ),
                          ),
                        ),
                        // CardWidget(
                        //   gradient: const LinearGradient(
                        //     begin: Alignment.topLeft,
                        //     end: Alignment.bottomRight,
                        //     colors: [Color(0xff3A4DB2), Color(0xffF8A29D)],
                        //   ),
                        //   child: Icon(item.icon, color: ColorConstant.white),
                        // ),
                        SpacerWidget.small(),
                        TextWidget.caption(
                          item.label,
                          context: context,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
            SpacerWidget.xlarge(),

            /// Teaching Statistics
            TextWidget.heading4('Upcoming Sections', context: context),
            SpacerWidget.medium(),
            Column(
              children: [
                Card(
                  elevation: PaddingConstant.cardElevation,
                  margin: PaddingConstant.itemMargin,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      PaddingConstant.borderRadius,
                    ),
                    side: BorderSide(color: colorScheme.outline),
                  ),
                  child: ListTile(
                    title: TextWidget.heading4('10 B', context: context),
                    trailing: TextWidget.body(
                      '10:00 - 10:45',
                      context: context,
                    ),
                  ),
                ),
                Card(
                  elevation: PaddingConstant.cardElevation,
                  margin: PaddingConstant.itemMargin,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      PaddingConstant.borderRadius,
                    ),
                    side: BorderSide(color: colorScheme.outline),
                  ),
                  child: ListTile(
                    title: TextWidget.heading4('10 C', context: context),
                    trailing: TextWidget.body(
                      '11:00 - 11:45',
                      context: context,
                    ),
                  ),
                ),
                Card(
                  elevation: PaddingConstant.cardElevation,
                  margin: PaddingConstant.itemMargin,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      PaddingConstant.borderRadius,
                    ),
                    side: BorderSide(color: colorScheme.outline),
                  ),
                  child: ListTile(
                    title: TextWidget.heading4('9 A', context: context),
                    trailing: TextWidget.body(
                      '11:45 - 12:30',
                      context: context,
                    ),
                  ),
                ),
              ],
            ),

            SpacerWidget.xlarge(),

            /// Quick Actions
            TextWidget.heading4('Today\'s Homework', context: context),
            SpacerWidget.medium(),
            Column(
              children: [
                Card(
                  elevation: PaddingConstant.cardElevation,
                  margin: PaddingConstant.itemMargin,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      PaddingConstant.borderRadius,
                    ),
                    side: BorderSide(color: colorScheme.outline),
                  ),
                  child: ListTile(
                    title: TextWidget.heading4('10 B', context: context),
                    subtitle: TextWidget.caption(
                      'Newton\'s 3rd Law',
                      context: context,
                    ),
                  ),
                ),
                Card(
                  elevation: PaddingConstant.cardElevation,
                  margin: PaddingConstant.itemMargin,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      PaddingConstant.borderRadius,
                    ),
                    side: BorderSide(color: colorScheme.outline),
                  ),
                  child: ListTile(
                    title: TextWidget.heading4('10 C', context: context),
                    subtitle: TextWidget.caption(
                      'Hooke\'s Law',
                      context: context,
                    ),
                  ),
                ),
                Card(
                  elevation: PaddingConstant.cardElevation,
                  margin: PaddingConstant.itemMargin,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      PaddingConstant.borderRadius,
                    ),
                    side: BorderSide(color: colorScheme.outline),
                  ),
                  child: ListTile(
                    title: TextWidget.heading4('9 A', context: context),
                    subtitle: TextWidget.caption('Motion', context: context),
                  ),
                ),
              ],
            ),
            SpacerWidget.large(),
          ],
        ),
      ),
    );
  }
}

final List<_GridItem> gridItems = [
  _GridItem(
    icon: Icons.task,
    label: "Mark Attendance",
    pageName: AppRoutes.markAttendance,
  ),
  _GridItem(
    icon: Icons.bar_chart_rounded,
    label: "View \nReport",
    pageName: AppRoutes.viewReport,
  ),
  _GridItem(
    icon: Icons.people_alt_outlined,
    label: "View Students",
    pageName: AppRoutes.viewStudents,
  ),
  _GridItem(
    icon: Icons.campaign_outlined,
    label: "Announce Now",
    pageName: AppRoutes.announceNow,
  ),
];

class _GridItem {
  final IconData icon;
  final String label;
  final String pageName;
  _GridItem({required this.icon, required this.label, required this.pageName});
}
