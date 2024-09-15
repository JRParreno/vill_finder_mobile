import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vill_finder/core/extension/spacer_widgets.dart';
import 'package:vill_finder/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:vill_finder/gen/assets.gen.dart';
import 'package:vill_finder/gen/colors.gen.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: ColorName.primary,
        ),
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'Vill Finder',
              style: textTheme.titleMedium?.copyWith(
                color: ColorName.primary,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          Text(
            'Welcome back!',
            style: textTheme.labelSmall?.copyWith(
              color: ColorName.primary,
            ),
          ),
          Text(
            'To continue please use Google Account.',
            style: textTheme.labelSmall?.copyWith(
              color: ColorName.primary,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              key: const Key('googleSignInButton'),
              onTap: () {
                context.read<AuthBloc>().add(AuthGoogleSignInEvent());
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: ColorName.primary, width: 5),
                    borderRadius: BorderRadius.circular(15)),
                padding: const EdgeInsets.all(25),
                height: 100,
                width: 100,
                child: Assets.images.icon.google.image(),
              ),
            ),
          ),
        ].withSpaceBetween(height: 20),
      ),
    );
  }
}
