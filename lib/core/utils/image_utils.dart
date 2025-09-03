import 'package:cached_network_image/cached_network_image.dart';
import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:flutter/material.dart';

class ImageUtils {
  static Widget buildCachedImage({
    required String imageUrl,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    Widget? placeholder,
    Widget? errorWidget,
  }) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) =>
          placeholder ?? const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) =>
          errorWidget ?? const Icon(Icons.error, color: ColorConstant.red),
    );
  }

  static Widget buildAvatar({
    required String imageUrl,
    double radius = 30,
    Widget? placeholder,
    Widget? errorWidget,
  }) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: CachedNetworkImageProvider(imageUrl),
      onBackgroundImageError: (exception, stackTrace) {
        // Handle error if needed
      },
      child: placeholder,
    );
  }

  static Widget buildProfileImage({
    required String imageUrl,
    double size = 100,
    BoxFit fit = BoxFit.cover,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size / 2),
      child: buildCachedImage(
        imageUrl: imageUrl,
        width: size,
        height: size,
        fit: fit,
        placeholder: Container(
          width: size,
          height: size,
          color: ColorConstant.grey300,
          child: Icon(
            Icons.person,
            size: 50,
            color: ColorConstant.textSecondaryLight,
          ),
        ),
        errorWidget: Container(
          width: size,
          height: size,
          color: ColorConstant.grey300,
          child: const Icon(Icons.error, size: 50, color: ColorConstant.red),
        ),
      ),
    );
  }
}
