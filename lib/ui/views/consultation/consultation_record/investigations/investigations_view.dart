import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/res/styles.dart';
import 'package:gericare_doctor/ui/views/consultation/consultation_record/investigations/investigations_view_model.dart';
import 'package:gericare_doctor/ui/widgets/app_bar_widget.dart';
import 'package:gericare_doctor/ui/widgets/primary_button.dart';
import 'package:gericare_doctor/ui/widgets/search_bar_widget.dart';
import 'package:stacked/stacked.dart';

class InvestigationsView extends StatelessWidget {
  const InvestigationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ViewModelBuilder<InvestigationsViewModel>.reactive(
      viewModelBuilder: () => InvestigationsViewModel(),
      builder: (context, vm, _) {
        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppBarWidget(
            title: 'Investigations',
            showBack: true,
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            child: PrimaryButton(
              label: "Save Investigations",
              onPressed: () => vm.openDateSheet(context),
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: SearchBarField(
                    controller: vm.searchController,
                    hintText: 'Search Instructions',
                    onChanged: (v) {
                      vm.search = v;
                      vm.notifyListeners();
                    }),
              ),

              /// SELECTED COUNT
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${vm.selectedCount} Selected",
                    style: AppTextStyle.bodyText2Bold,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              /// LIST
              Expanded(
                child: ListView.separated(
                  itemCount: vm.filtered.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final item = vm.filtered[index];
                    return ListTile(
                      title: Text(
                        item.name,
                        style: AppTextStyle.bodyText1.copyWith(fontSize: 14),
                      ),
                      trailing: Icon(
                        item.selected
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        color: item.selected
                            ? const Color(0xFF66B37D)
                            : Colors.grey,
                      ),
                      onTap: () => vm.toggleItem(item),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class InvestigationDateSheet extends StatefulWidget {
  const InvestigationDateSheet({super.key});

  @override
  State<InvestigationDateSheet> createState() => _InvestigationDateSheetState();
}

class _InvestigationDateSheetState extends State<InvestigationDateSheet> {
  String? date;

  final dates = [
    "Today",
    "Yesterday",
    "Last Week",
    "Custom Date",
  ];

  @override
  Widget build(BuildContext context) {
    final colors=context.colors;
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Investigation Date", style: AppTextStyle.title1Bold),
            const SizedBox(height: 16),
            const Text("Date"),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
                decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 12,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: colors.outline.withOpacity(0.6),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: colors.primary,
                width: 1.2,
              ),
            )),
      
              value: date,
              hint: const Text("Select Date"),
              items: dates
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => setState(() => date = v),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: "Save",
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
