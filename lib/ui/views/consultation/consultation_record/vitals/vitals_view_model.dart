import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/base/base_view_model.dart';
import 'package:gericare_doctor/ui/views/consultation/consultation_record/vitals/vitals_view.dart';

enum VitalType {
  bloodPressure,
  bpLying,
  bpSitting,
  bpStanding,
  temperature,
  spo2,
  randomBloodSugar,
  pulseRate,
  respiratoryRate,
  height,
  weight,
  painScore,
  urineOutput,
  stoolOutput,
}

class VitalItem {
  final VitalType type;
  final String title;
  final String icon;
  bool selected;

  VitalItem({
    required this.type,
    required this.title,
    required this.icon,
    this.selected = false,
  });

  VitalItem copyWith({bool? selected}) {
    return VitalItem(
      type: type,
      title: title,
      icon: icon,
      selected: selected ?? this.selected,
    );
  }
}

class VitalsViewModel extends VGTSBaseViewModel {
  final List<VitalItem> vitals = [
    VitalItem(
      type: VitalType.bloodPressure,
      title: "Blood Pressure",
      icon: 'assets/main/consultation/droplets.png',
    ),
    VitalItem(
      type: VitalType.bpLying,
      title: "Postural Blood Pressure (Lying)",
      icon: 'assets/main/consultation/droplets.png',
    ),
    VitalItem(
      type: VitalType.bpSitting,
      title: "Postural Blood Pressure (Sitting)",
      icon: 'assets/main/consultation/droplets.png',
    ),
    VitalItem(
      type: VitalType.bpStanding,
      title: "Postural Blood Pressure (Standing)",
      icon: 'assets/main/consultation/droplets.png',
    ),
    VitalItem(
      type: VitalType.temperature,
      title: "Temperature",
      icon: 'assets/main/consultation/temperature.png',
    ),
    VitalItem(
      type: VitalType.spo2,
      title: "SPO₂",
      icon: 'assets/main/consultation/spo2.png',
    ),
    VitalItem(
      type: VitalType.randomBloodSugar,
      title: "Random Blood Sugar",
      icon: 'assets/main/consultation/singledrop.png',
    ),
    VitalItem(
      type: VitalType.pulseRate,
      title: "Pulse Rate",
      icon: 'assets/main/consultation/pulse.png',
    ),
    VitalItem(
      type: VitalType.respiratoryRate,
      title: "Respiratory Rate",
      icon: 'assets/main/consultation/rate.png',
    ),
    VitalItem(
      type: VitalType.height,
      title: "Height",
      icon: 'assets/main/consultation/height.png',
    ),
    VitalItem(
      type: VitalType.weight,
      title: "Weight",
      icon: 'assets/main/consultation/weight.png',
    ),
    VitalItem(
      type: VitalType.painScore,
      title: "Pain Score",
      icon: 'assets/main/consultation/pain.png',
    ),
    VitalItem(
      type: VitalType.urineOutput,
      title: "Urine Output",
      icon: 'assets/main/consultation/urine.png',
    ),
    VitalItem(
      type: VitalType.stoolOutput,
      title: "Stool Output",
      icon: 'assets/main/consultation/stool.png',
    ),
  ];

  int get selectedCount => vitals.where((e) => e.selected).length;

  void toggleVital(BuildContext context, VitalItem item) {
    item.selected = !item.selected;
    notifyListeners();

    if (item.selected) {
      openVitalBottomSheet(context, item.type);
    }
  }

  void openVitalBottomSheet(BuildContext context, VitalType type) {
    switch (type) {
      case VitalType.temperature:
        openTemperatureSheet(context);
        break;
      case VitalType.spo2:
        openSpo2Sheet(context);
        break;
      // add remaining cases
      default:
        break;
    }
  }

  void openTemperatureSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const TemperatureSheet(),
    );
  }

  void openSpo2Sheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const TemperatureSheet(),
    );
  }
}
