import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vill_finder/features/auth/presentation/bloc/auth_bloc.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            context.read<AuthBloc>().add(AuthUserLogout());
            Navigator.of(context).pop();
          },
          child: const Text('Logout'),
        ),
      ),
    );
  }
}
