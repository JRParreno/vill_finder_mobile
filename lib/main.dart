// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:vill_finder/core/blocs/bloc_providers.dart';
import 'package:vill_finder/core/config/shared_prefences_keys.dart';
import 'package:vill_finder/core/notifier/shared_preferences_notifier.dart';

import 'package:vill_finder/core/router/index.dart';
import 'package:vill_finder/core/theme/theme.dart';
import 'package:vill_finder/dependency_injection_config.dart';
import 'package:vill_finder/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:vill_finder/firebase_options.dart';
import 'package:vill_finder/dependency_injection_config.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.initDependencies();

  final router = routerConfig();

  serviceLocator<FirebaseAuth>().authStateChanges().listen((User? user) {
    router.refresh();
  });

  runApp(
    MultiBlocProvider(
      providers: BlocProviders.blocs(di.serviceLocator),
      child: const MyApp(),
    ),
  );
}

final router = routerConfig();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isConnectedToInternet = true;
  StreamSubscription? _internetConnectionStreamSubscription;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    checkInternetConnection();
    checkIsUserLoggedIn();
    // Future.delayed(const Duration(seconds: 2), () {
    //   FlutterNativeSplash.remove();
    // });
  }

  @override
  void dispose() {
    _internetConnectionStreamSubscription?.cancel();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightThemeMode,
        routerConfig: router,
        scaffoldMessengerKey: scaffoldMessengerKey,
      ),
    );
  }

  void checkIsUserLoggedIn() {
    // This will handle to get profile if user is logged in
    final sharedPreferencesNotifier =
        GetIt.instance<SharedPreferencesNotifier>();
    final bool isLoggedIn = sharedPreferencesNotifier.getValue(
        SharedPreferencesKeys.isLoggedIn, false);

    if (isLoggedIn) {
      context.read<AuthBloc>().add(AuthIsUserLoggedIn());
    }
  }

  void checkInternetConnection() {
    _internetConnectionStreamSubscription =
        InternetConnection().onStatusChange.listen((event) {
      switch (event) {
        case InternetStatus.connected:
          setState(() => isConnectedToInternet = true);
          break;
        case InternetStatus.disconnected:
          setState(() => isConnectedToInternet = false);
          break;
        default:
          setState(() => isConnectedToInternet = false);
      }

      if (!isConnectedToInternet) {
        const snackBar = SnackBar(
          content: Text("You are disconnected to the internet."),
        );

        scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
      }
    });
  }
}
