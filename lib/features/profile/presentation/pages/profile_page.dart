import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:vill_finder/core/common/cubit/app_user_cubit.dart';
import 'package:vill_finder/core/config/shared_prefences_keys.dart';
import 'package:vill_finder/core/extension/spacer_widgets.dart';
import 'package:vill_finder/core/notifier/shared_preferences_notifier.dart';
import 'package:vill_finder/core/router/app_routes.dart';
import 'package:vill_finder/gen/assets.gen.dart';
import 'package:vill_finder/gen/colors.gen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          'Settings',
          style: textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<AppUserCubit, AppUserState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        if (state is AppUserLoggedIn) ...[
                          const SizedBox.shrink()
                        ] else ...[
                          Container(
                            height: MediaQuery.of(context).size.height * 0.35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.blue,
                            ),
                            child: Assets.lottie.lottieMap.lottie(),
                          )
                        ],
                        buildListTile(
                            title: 'Terms & Conditions',
                            onTap: () {
                              onDisplayMessage(
                                  'This feature is not yet implemented');
                            },
                            iconData: Icons.shield),
                        buildListTile(
                          title: 'About Us',
                          onTap: () {
                            context.pushNamed(AppRoutes.about.name);
                          },
                          iconData: Icons.report,
                        ),
                        buildListTile(
                          title: state is AppUserLoggedIn ? 'Logout' : 'Login',
                          onTap: state is AppUserLoggedIn
                              ? handleOnTapLogout
                              : handleToLogin,
                          iconData: state is AppUserLoggedIn
                              ? Icons.logout
                              : Icons.login,
                        ),
                      ].withSpaceBetween(height: 10),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'VillFinder v1.0.10',
                  style:
                      textTheme.bodySmall?.copyWith(color: ColorName.greyFont),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildListTile({
    required String title,
    required VoidCallback onTap,
    required IconData iconData,
  }) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          color: ColorName.borderColor,
        ),
      ),
      iconColor: ColorName.darkerGreyFont,
      title: Text(
        title,
        style: const TextStyle(color: ColorName.darkerGreyFont),
      ),
      leading: Icon(iconData),
      onTap: onTap,
      trailing: const Icon(
        Icons.chevron_right_outlined,
        size: 30,
        color: ColorName.darkerGreyFont,
      ),
    );
  }

  void handleOnTapLogout() async {
    final snackBar = SnackBar(
      content: const Text('Do you want to proceed?'),
      action: SnackBarAction(
        label: 'Yes',
        onPressed: () {
          // Perform the action for "Yes"
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Logging out....'),
              duration: Duration(milliseconds: 200),
            ),
          );
          final sharedPreferencesNotifier =
              GetIt.instance<SharedPreferencesNotifier>();
          sharedPreferencesNotifier.setValue(
              SharedPreferencesKeys.isLoggedIn, false);

          sharedPreferencesNotifier.setValue(
              SharedPreferencesKeys.accessToken, '');

          sharedPreferencesNotifier.setValue(
              SharedPreferencesKeys.refreshToken, '');

          Future.delayed(const Duration(seconds: 1), () {
            context.go(AppRoutes.login.path);
            context.read<AppUserCubit>().logout();
          });
        },
      ),
      showCloseIcon: true,
      duration: const Duration(seconds: 5),
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void handleToLogin() {
    context.go(AppRoutes.login.path);
  }

  void onDisplayMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      showCloseIcon: true,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
