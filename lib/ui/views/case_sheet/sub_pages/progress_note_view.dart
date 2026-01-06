import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/res/helper.dart';
import 'package:gericare_doctor/core/res/styles.dart';
import 'package:gericare_doctor/ui/widgets/app_bar_widget.dart';
import 'package:gericare_doctor/ui/widgets/horizontal_calendar.dart';

class ProgressNotesView extends StatefulWidget {
  const ProgressNotesView({super.key});

  @override
  State<ProgressNotesView> createState() => _ProgressNotesViewState();
}

class _ProgressNotesViewState extends State<ProgressNotesView> {
  DateTime selectedDate = DateTime.now();

  void onDateSelected(DateTime date) {
    setState(() => selectedDate = date);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: _buildAppBar(
        context,
        "Progress Notes",
        "Last Updated on Wed, Nov 7 2025",
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: dummyProgressNotes.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return ProgressNoteCard(note: dummyProgressNotes[index]);
        },
      ),
    );
  }

  /// 🔹 YOUR PROVIDED APPBAR (UNCHANGED)
  PreferredSize _buildAppBar(
      BuildContext context, String title, String subTitle) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(180),
      child: AppBarWidget(
        title: title,
        subtitle: subTitle,
        showBack: true,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Helper.getFormattedDate(),
                  style: AppTextStyle.title1Bold.copyWith(fontSize: 16),
                ),
                HorizontalCalendar(
                  selectedDate: selectedDate,
                  onDateSelected: onDateSelected,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProgressNoteCard extends StatelessWidget {
  final ProgressNote note;

  const ProgressNoteCard({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage(note.avatar),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note.name,
                      style: AppTextStyle.bodyText2Bold
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      note.time,
                      style: AppTextStyle.bodyText2SubText
                          .copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// NOTE TEXT
          Text(
            note.note,
            style: AppTextStyle.bodyText2.copyWith(
              fontWeight: FontWeight.w400,
              color: Color(0xFF7A7A7A),
            ),
          ),
        ],
      ),
    );
  }
}

final dummyProgressNotes = [
  ProgressNote(
    name: "Priya Nair",
    time: "10:30 AM",
    note: "Patient received all the tablets and care.",
    avatar: "assets/main/ch_profile.png",
  ),
  ProgressNote(
    name: "Priya Nair",
    time: "1:30 PM",
    note: "Patient position changed after 2 hours, and woke up after 1 hour.",
    avatar: "assets/main/ch_profile.png",
  ),
  ProgressNote(
    name: "Vinay Kumar",
    time: "4:30 PM",
    note: "Patient position changed after 2 hours, and woke up after 1 hour.",
    avatar: "assets/main/ch_profile.png",
  ),
];

class ProgressNote {
  final String name;
  final String time;
  final String note;
  final String avatar; // asset path

  ProgressNote({
    required this.name,
    required this.time,
    required this.note,
    required this.avatar,
  });
}
