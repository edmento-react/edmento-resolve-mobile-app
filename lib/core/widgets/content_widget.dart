import 'dart:io';

import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/utils/screen_util.dart';
import 'package:edmentoresolve/core/widgets/card_widget.dart';
import 'package:edmentoresolve/core/widgets/icon_widget.dart';
import 'package:edmentoresolve/core/widgets/spacer_widget.dart';
import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget cardContent({
  required BuildContext context,
  required IconData icon,
  required String title,
  String? value,
  required Color color,
  required String subtitle,
  VoidCallback? onTap,
}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  return CardWidget(
    onTap: onTap,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconWidget.withContainer(
          icon,
          iconColor: color,
          backgroundColor: color.withOpacity(0.1),
        ),
        SpacerWidget.medium(),
        value == null
            ? SizedBox()
            : TextWidget.heading2(
                value,
                color: isDark
                    ? ColorConstant.textPrimaryColorDark
                    : ColorConstant.textPrimaryColorLight,
                textAlign: TextAlign.center,
                context: context,
              ),
        SpacerWidget.tiny(),
        TextWidget.body(
          title,
          fontWeight: FontWeight.w600,
          color: isDark
              ? ColorConstant.textPrimaryColorDark
              : ColorConstant.textPrimaryColorLight,
          textAlign: TextAlign.center,
          context: context,
        ),
        SpacerWidget.tiny(),
        TextWidget.caption(
          subtitle,
          color: isDark
              ? ColorConstant.textCaptionColorDark
              : ColorConstant.textCaptionColorLight,
          textAlign: TextAlign.center,
          context: context,
        ),
      ],
    ),
  );
}

Widget tileContent({
  required BuildContext context,
  IconData? icon,
  required String title,
  required String subtitle,
  String? deadline,
  String? priority,
  String? time,
  Color? color,
  VoidCallback? onTap,
  bool isDestructive = false,
  bool isTrailing = false,
}) {
  return CardWidget(
    onTap: onTap,
    padding: ScreenUtil.getAdaptivePadding(
      horizontal: 20,
      vertical: 16,
      tabletHorizontal: 24,
      tabletVertical: 20,
    ),
    child: Row(
      children: [
        icon != null
            ? IconWidget.withContainer(
                icon,
                iconColor: isDestructive
                    ? ColorConstant.red
                    : color ?? ColorConstant.blue,
                backgroundColor: isDestructive
                    ? ColorConstant.red.withOpacity(0.1)
                    : color != null
                    ? color.withOpacity(0.1)
                    : ColorConstant.blue.withOpacity(0.1),
              )
            : Container(
                width: ScreenUtil.getWidth(4),
                height: ScreenUtil.getHeight(40),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(ScreenUtil.getRadius(2)),
                    topRight: Radius.circular(ScreenUtil.getRadius(2)),
                  ),
                ),
              ),
        SpacerWidget.widthMedium(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget.body(
                title,
                fontWeight: FontWeight.w600,
                context: context,
              ),
              SpacerWidget.tiny(),
              TextWidget.caption(
                subtitle,
                color: ColorConstant.textCaptionColorLight,
                textAlign: TextAlign.center,
                context: context,
              ),
              SpacerWidget.tiny(),
              time != null
                  ? TextWidget.small(
                      time,
                      color: ColorConstant.textCaptionColorLight,
                      context: context,
                    )
                  : color == null
                  ? SizedBox()
                  : Row(
                      children: [
                        IconWidget.tiny(
                          Icons.schedule,
                          color: ColorConstant.textCaptionColorLight,
                        ),
                        SpacerWidget.widthTiny(),
                        TextWidget.small(
                          deadline!,
                          color: ColorConstant.textCaptionColorLight,
                          context: context,
                        ),
                        SpacerWidget.widthMedium(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil.getWidth(8),
                            vertical: ScreenUtil.getHeight(2),
                          ),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(
                              ScreenUtil.getRadius(4),
                            ),
                          ),
                          child: TextWidget.small(
                            priority!,
                            color: color,
                            fontWeight: FontWeight.w600,
                            context: context,
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
        isTrailing
            ? IconWidget.tiny(
                Platform.isIOS
                    ? CupertinoIcons.right_chevron
                    : Icons.chevron_right,
                color: ColorConstant.grey400,
                size: ScreenUtil.getIconSize(),
              )
            : SizedBox(),
      ],
    ),
  );
}
