import 'package:doctor/core/styles/colors.dart';
import 'package:doctor/core/styles/text_styles.dart';
import 'package:doctor/features/consultation/consultation_history/consultation_history_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ConsultationHistoryDetailsView extends StatelessWidget {
  final ConsultationHistoryItem item;

  const ConsultationHistoryDetailsView({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final isToday = _isToday(item.dateTime);

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: AppColor.textOnPrimary, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isToday ? 'Today' : DateFormat('EEEE').format(item.dateTime),
              style: AppTextStyle.bodyText1.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              DateFormat('h:mm a, MMM d, yyyy').format(item.dateTime),
              style: AppTextStyle.bodyText2SubText.copyWith(fontSize: 12.sp),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(72.h),
          child: Container(
            padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 12.h),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: AppColor.containerOutline),
              ),
            ),
            child: _DoctorHeader(
              name: item.doctorName,
              speciality: item.speciality,
            ),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          /// SYMPTOMS SECTION
          if (item.symptoms.isNotEmpty)
            _SectionCard(
              title: 'Symptoms',
              icon: Icons.sick_outlined,
              iconColor: const Color(0xFFFF5722),
              children: item.symptoms.map((s) => _BulletPoint(text: s)).toList(),
            ),

          if (item.symptoms.isNotEmpty) SizedBox(height: 16.h),

          /// DIAGNOSIS SECTION
          if (item.diagnosis.isNotEmpty)
            _SectionCard(
              title: 'Diagnosis',
              icon: Icons.assignment_outlined,
              iconColor: const Color(0xFF2196F3),
              children: item.diagnosis.map((d) => _BulletPoint(text: d)).toList(),
            ),

          if (item.diagnosis.isNotEmpty) SizedBox(height: 16.h),

          /// MEDICINES SECTION
          if (item.medicines.isNotEmpty)
            _SectionCard(
              title: 'Medicines Prescribed',
              icon: Icons.medication_outlined,
              iconColor: const Color(0xFF4CAF50),
              children: item.medicines.map((m) => _MedicineItem(name: m)).toList(),
            ),

          if (item.medicines.isNotEmpty) SizedBox(height: 16.h),

          /// SUMMARY SECTION
          _SectionCard(
            title: 'Consultation Summary',
            icon: Icons.description_outlined,
            iconColor: AppColor.primary,
            children: [
              Text(
                item.summary,
                style: AppTextStyle.bodyText2.copyWith(
                  fontSize: 13.sp,
                  height: 1.5,
                ),
              ),
            ],
          ),

          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }
}

/// Doctor header widget
class _DoctorHeader extends StatelessWidget {
  final String name;
  final String speciality;

  const _DoctorHeader({
    required this.name,
    required this.speciality,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 50.w,
          height: 50.w,
          decoration: BoxDecoration(
            color: AppColor.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Center(
            child: Text(
              name.split(' ').last[0],
              style: TextStyle(
                color: AppColor.primary,
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: AppTextStyle.bodyText1.copyWith(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              speciality,
              style: AppTextStyle.bodyText2SubText.copyWith(
                fontSize: 13.sp,
                color: AppColor.secondaryText,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Section card widget
class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final List<Widget> children;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER
          Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.08),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14.r),
                topRight: Radius.circular(14.r),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, size: 20, color: iconColor),
                SizedBox(width: 10.w),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: iconColor,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),

          /// CONTENT
          Padding(
            padding: EdgeInsets.all(14.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}

/// Bullet point widget
class _BulletPoint extends StatelessWidget {
  final String text;

  const _BulletPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6.w,
            height: 6.w,
            margin: EdgeInsets.only(top: 6.h, right: 10.w),
            decoration: BoxDecoration(
              color: AppColor.primary.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: AppTextStyle.bodyText2.copyWith(fontSize: 13.sp),
            ),
          ),
        ],
      ),
    );
  }
}

/// Medicine item widget
class _MedicineItem extends StatelessWidget {
  final String name;

  const _MedicineItem({required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFF4CAF50).withOpacity(0.08),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFF4CAF50).withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.medication, size: 18, color: const Color(0xFF4CAF50)),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              name,
              style: AppTextStyle.bodyText2.copyWith(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
