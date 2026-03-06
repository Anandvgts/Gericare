import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart'; // enable later if needed

class AuthCircleImage extends StatelessWidget {
  final String imagePath;
  final double imageSize;

  const AuthCircleImage({
    super.key,
    required this.imagePath,
    this.imageSize = 64,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: 64.w,
      height: 64.w,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          // color: colors.primary.withOpacity(0.1),
          color: Colors.transparent),
      alignment: Alignment.center,
      child: Image.asset(
        imagePath,
        width: imageSize.w,
        height: imageSize.w,
        fit: BoxFit.contain,
      ),

      // 🔁 SVG SUPPORT (enable when needed)
      /*
      child: SvgPicture.asset(
        imagePath,
        width: imageSize.w,
        height: imageSize.w,
        colorFilter:
            ColorFilter.mode(colors.primary, BlendMode.srcIn),
      ),
      */
    );
  }
}
