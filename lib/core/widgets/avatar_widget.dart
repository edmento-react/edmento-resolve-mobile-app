import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvatarWidget extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final double? size;
  final Color? backgroundColor;
  final Color? textColor;
  final IconData? placeholder;

  const AvatarWidget({
    super.key,
    this.imageUrl,
    this.name,
    this.size,
    this.backgroundColor,
    this.textColor,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    final avatarSize = size ?? 40.w;

    return CircleAvatar(
      radius: avatarSize / 2,
      backgroundColor: backgroundColor ?? ColorConstant.blue.withOpacity(0.1),
      foregroundColor: textColor ?? ColorConstant.blue,
      backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
      child: imageUrl == null
          ? (name != null
                ? Text(
                    _getInitials(name!),
                    style: TextStyle(
                      fontSize: (avatarSize * 0.4).sp,
                      fontWeight: FontWeight.w600,
                      color: textColor ?? ColorConstant.blue,
                    ),
                  )
                : Icon(
                    placeholder ?? Icons.person,
                    size: (avatarSize * 0.6).w,
                    color: textColor ?? ColorConstant.blue,
                  ))
          : null,
    );
  }

  String _getInitials(String name) {
    final words = name.trim().split(' ');
    if (words.isEmpty) return '';
    if (words.length == 1) return words[0][0].toUpperCase();
    return '${words[0][0]}${words[1][0]}'.toUpperCase();
  }
}
