import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:vill_finder/core/common/widgets/custom_elevated_btn.dart';
import 'package:vill_finder/core/config/shared_prefences_keys.dart';
import 'package:vill_finder/core/notifier/shared_preferences_notifier.dart';
import 'package:vill_finder/core/router/app_routes.dart';
import 'package:vill_finder/gen/assets.gen.dart';
import 'package:vill_finder/gen/colors.gen.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.45;
    final spaceTitle = MediaQuery.of(context).size.height * 0.05;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: spaceTitle),
              Text(
                'Vill Finder',
                style: textTheme.displaySmall?.copyWith(
                  color: ColorName.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
              Assets.lottie.lottieMap.lottie(height: height),
              Text(
                'Welcome',
                style: textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              CustomElevatedBtn(
                onTap: () => context.pushNamed(AppRoutes.login.name),
                title: 'Continue',
                buttonType: ButtonType.outline,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void goToHomePage() {
    final sharedPreferencesNotifier =
        GetIt.instance<SharedPreferencesNotifier>();

    sharedPreferencesNotifier.setValue(SharedPreferencesKeys.isOnBoarded, true);
    GoRouter.of(context).go(AppRoutes.login.path);
  }
}
