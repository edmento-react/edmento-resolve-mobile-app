import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool automaticallyImplyLeading;
  final double elevation;
  final bool centerTitle;
  final Widget? titleWidget;

  const AppBarWidget({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.backgroundColor,
    this.foregroundColor,
    this.automaticallyImplyLeading = true,
    this.elevation = 0,
    this.centerTitle = true,
    this.titleWidget,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          AppBar(
            title:
                titleWidget ??
                TextWidget.heading2(
                  title ?? "Title",
                  context: context,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                  color: foregroundColor,
                ),
            surfaceTintColor: ColorConstant.transparent,
            // actions: actions,
            leading: leading,

            leadingWidth: 55,
            titleSpacing: 10,

            backgroundColor:
                backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
            foregroundColor:
                foregroundColor ?? Theme.of(context).textTheme.bodyLarge!.color,
            automaticallyImplyLeading: automaticallyImplyLeading,
            elevation: elevation,
            centerTitle: centerTitle,
            // toolbarHeight: kToolbarHeight + 20.h,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: 150,
              height: double.infinity,
              child: Stack(
                fit: StackFit.loose,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/appbar2.png'),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    bottom: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: actions ?? [],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 8.h);
}
