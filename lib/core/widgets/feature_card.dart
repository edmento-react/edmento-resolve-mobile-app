import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/constants/style_constant.dart';
import 'package:edmentoresolve/core/utils/screen_util.dart';
import 'package:flutter/material.dart';

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      elevation: ScreenUtil.getResponsiveValue(
        smallPhone: 1,
        mobile: 2,
        tablet: 3,
        largeTablet: 4,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ScreenUtil.getRadius(16)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(ScreenUtil.getRadius(16)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ScreenUtil.getRadius(16)),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withValues(alpha: 0.1),
                color.withValues(alpha: 0.05),
              ],
            ),
          ),
          child: Padding(
            padding: ScreenUtil.getAdaptivePadding(
              smallPhoneHorizontal: 12,
              smallPhoneVertical: 10,
              horizontal: 18,
              vertical: 15,
              tabletHorizontal: 24,
              tabletVertical: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(
                    ScreenUtil.getResponsiveValue(
                      smallPhone: 8,
                      mobile: 10,
                      tablet: 16,
                      largeTablet: 20,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(
                      ScreenUtil.getRadius(12),
                    ),
                  ),
                  child: Icon(
                    icon,
                    size: ScreenUtil.getResponsiveValue(
                      smallPhone: 28,
                      mobile: 32,
                      tablet: 36,
                      largeTablet: 40,
                    ),
                    color: color,
                  ),
                ),
                SizedBox(height: ScreenUtil.getHeight(12)),
                Text(
                  title,
                  style: StyleConstant.heading3(
                    context,
                  ).copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: ScreenUtil.getHeight(4)),
                Text(
                  subtitle,
                  style: StyleConstant.caption(
                    context,
                  ).copyWith(color: ColorConstant.textSecondaryColorLight),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
