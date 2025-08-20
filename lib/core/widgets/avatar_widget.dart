import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/constants/style_constant.dart';
import 'package:edmentoresolve/core/utils/image_utils.dart';
import 'package:edmentoresolve/core/utils/screen_util.dart';
import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final double? size;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final Widget? placeholder;
  final Widget? errorWidget;

  const AvatarWidget({
    super.key,
    this.imageUrl,
    this.name,
    this.size,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    final avatarSize =
        size ??
        ScreenUtil.getResponsiveValue(
          smallPhone: 48,
          mobile: 60,
          tablet: 72,
          largeTablet: 80,
        );

    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(avatarSize / 2),
        child: ImageUtils.buildCachedImage(
          imageUrl: imageUrl!,
          width: avatarSize,
          height: avatarSize,
          fit: BoxFit.cover,
          placeholder:
              placeholder ??
              Container(
                width: avatarSize,
                height: avatarSize,
                color: ColorConstant.grey300,
                child: Icon(
                  Icons.person,
                  size: avatarSize * 0.4,
                  color: ColorConstant.textSecondaryColorLight,
                ),
              ),
          errorWidget: errorWidget ?? _buildFallbackAvatar(avatarSize, context),
        ),
      );
    }

    return _buildFallbackAvatar(avatarSize, context);
  }

  Widget _buildFallbackAvatar(double size, BuildContext context) {
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: backgroundColor ?? ColorConstant.blueLight,
      child: name != null && name!.isNotEmpty
          ? Text(
              name![0].toUpperCase(),
              style: StyleConstant.heading2(context).copyWith(
                fontSize: fontSize,
                color: textColor ?? ColorConstant.blue,
              ),
            )
          : Icon(
              Icons.person,
              size: size * 0.4,
              color: ColorConstant.textSecondaryColorLight,
            ),
    );
  }
}
