import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/res/colors.dart';
import 'package:gericare_doctor/core/res/images.dart';
import 'package:stacked/stacked.dart';
import 'splash_view_model.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      viewModelBuilder: () => SplashViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: AppColor.primary,
          body:  Center(
            child: Image.asset(Images.splashLogo,)
            ),
          
        );
      },
    );
  }
}
