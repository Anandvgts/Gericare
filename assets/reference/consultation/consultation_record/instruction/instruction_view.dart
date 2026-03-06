import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/res/styles.dart';
import 'package:gericare_doctor/ui/views/consultation/consultation_record/instruction/instruction_view_model.dart';
import 'package:gericare_doctor/ui/widgets/app_bar_widget.dart';
import 'package:gericare_doctor/ui/widgets/primary_button.dart';
import 'package:gericare_doctor/ui/widgets/search_bar_widget.dart';
import 'package:stacked/stacked.dart';

class InstructionsView extends StatelessWidget {
  const InstructionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ViewModelBuilder<InstructionsViewModel>.reactive(
      viewModelBuilder: () => InstructionsViewModel(),
      builder: (context, vm, _) {
        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppBarWidget(
            title: 'Instructions',
            showBack: true,
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            child: PrimaryButton(
              label: "Save Instructions",
              onPressed: () {
                // save logic
              },
            ),
          ),
          body: Column(
            children: [
              /// SEARCH
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

              /// CREATE OPTION
              if (vm.canCreate)
                ListTile(
                  leading: Icon(Icons.add, color: context.colors.onSecondary),
                  title: Text(
                    "Create \"${vm.search}\"",
                    style: TextStyle(color: context.colors.onSecondary),
                  ),
                  onTap: vm.createAndSelect,
                ),

              /// LIST
              Expanded(
                child: ListView.separated(
                  itemCount: vm.filtered.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final item = vm.filtered[index];
                    return ListTile(
                      title: Text(
                        item.text,
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
                      onTap: () => vm.toggle(item),
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
