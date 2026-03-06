// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:doctor/core/styles/text_styles.dart';

// class AssignedPatientsCard extends StatelessWidget {
//   final int completed;
//   final int total;

//   const AssignedPatientsCard({
//     super.key,
//     required this.completed,
//     required this.total,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final percent = total == 0 ? 0 : ((completed / total) * 100).round();

//     return Container(
//       padding: EdgeInsets.all(20.w),
//       decoration: BoxDecoration(
//         color: Theme.of(context).colorScheme.surface,
//         borderRadius: BorderRadius.circular(16.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Assigned Patients",
//             style: AppTextStyle.bodyText1.copyWith(
//               fontWeight: FontWeight.w600,
//             ),
//           ),

//           SizedBox(height: 16.h),

//           /// ✅ USE PROPS, NOT vm
//           AssignedPatientsProgressBar(
//             completed: completed,
//             total: total,
//             activeColor: Theme.of(context).colorScheme.onSecondary,
//           ),

//           SizedBox(height: 12.h),

//           // Row(
//           //   children: [
//           //     Text(
//           //       "$completed/$total ",
//           //       style: AppTextStyle.bodyText1,
//           //     ),
//           //     Text(
//           //       "Patients",
//           //       style: AppTextStyle.bodyText2SubText,
//           //     ),
//           //     const Spacer(),
//           //     Text(
//           //       "$percent %",
//           //       style: AppTextStyle.bodyText1,
//           //     ),
//           //   ],
//           // ),

//           Row(
//             children: [
//               Flexible(
//                 child: RichText(
//                   text: TextSpan(
//                     style: AppTextStyle.bodyText1,
//                     children: [
//                       TextSpan(
//                         text: "$completed/$total ",
//                         style: const TextStyle(fontWeight: FontWeight.w600),
//                       ),
//                       TextSpan(
//                         text: "Patients",
//                         style: AppTextStyle.bodyText2SubText,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const Spacer(),
//               Text(
//                 "$percent %",
//                 style: AppTextStyle.bodyText1.copyWith(
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class AssignedPatientsProgressBar extends StatelessWidget {
//   final int completed;
//   final int total;
//   final Color activeColor;

//   const AssignedPatientsProgressBar({
//     super.key,
//     required this.completed,
//     required this.total,
//     required this.activeColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     const segments = 20;
//     final filled = total == 0 ? 0 : ((completed / total) * segments).round();

//     return LayoutBuilder(
//       builder: (_, constraints) {
//         final pillWidth = (constraints.maxWidth - segments) / segments;

//         return SizedBox(
//           height: 12,
//           child: Row(
//             children: List.generate(segments, (i) {
//               final active = i < filled;

//               return Padding(
//                 padding: EdgeInsets.only(right: i == segments - 1 ? 0 : 2),
//                 child: ClipPath(
//                   clipper: _SlantedPillClipper(),
//                   child: Container(
//                     width: pillWidth,
//                     height: 8,
//                     color: active ? activeColor : const Color(0xFFE6E9ED),
//                   ),
//                 ),
//               );
//             }),
//           ),
//         );
//       },
//     );
//   }
// }

// class _SlantedPillClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final cut = size.height * 0.8;

//     return Path()
//       ..moveTo(cut, 0)
//       ..lineTo(size.width, 0)
//       ..lineTo(size.width - cut, size.height)
//       ..lineTo(0, size.height)
//       ..close();
//   }

//   @override
//   bool shouldReclip(_) => false;
// }

// ========================================
// 2. FIXED ASSIGNED PATIENTS CARD
// ========================================
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doctor/core/styles/text_styles.dart';

class AssignedPatientsCard extends StatelessWidget {
  final int completed;
  final int total;

  const AssignedPatientsCard({
    super.key,
    required this.completed,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final percent = total == 0 ? 0 : ((completed / total) * 100).round();

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Assigned Patients",
            style: AppTextStyle.bodyText1.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: 16.h),

          // Progress Bar
          AssignedPatientsProgressBar(
            completed: completed,
            total: total,
            activeColor: Theme.of(context).colorScheme.surfaceVariant,
          ),

          SizedBox(height: 12.h),

          // Stats Row - Fixed overflow
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "$completed/$total ",
                      style: AppTextStyle.bodyText1.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Patients",
                      style: AppTextStyle.bodyText2SubText,
                    ),
                  ],
                ),
              ),
              Text(
                "$percent %",
                style: AppTextStyle.bodyText1.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ========================================
// 3. FIXED PROGRESS BAR
// ========================================
class AssignedPatientsProgressBar extends StatelessWidget {
  final int completed;
  final int total;
  final Color activeColor;

  const AssignedPatientsProgressBar({
    super.key,
    required this.completed,
    required this.total,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    const segments = 22;
    final filled = total == 0 ? 0 : ((completed / total) * segments).round();

    return LayoutBuilder(
      builder: (_, constraints) {
        // Calculate width with proper spacing
        final spacing = 1.0;
        final totalSpacing = spacing * (segments - 1);
        final pillWidth = (constraints.maxWidth - totalSpacing) / segments;

        return SizedBox(
          height: 14.h,
          child: Row(
            children: List.generate(segments, (i) {
              final active = i < filled;

              return Container(
                // margin: EdgeInsets.only(right: i == segments - 1 ? 0 : spacing),
                child: ClipPath(
                  clipper: _SlantedPillClipper(),
                  child: Container(
                    width: pillWidth,
                    height: 10.h,
                    decoration: BoxDecoration(
                      color: active ? activeColor : const Color(0xFFE6E9ED),
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}

class _SlantedPillClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final slant = size.height * 0.7;

    return Path()
      ..moveTo(slant, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width - slant, size.height)
      ..lineTo(0, size.height)
      ..close();
  }

  @override
  bool shouldReclip(_) => false;
}
