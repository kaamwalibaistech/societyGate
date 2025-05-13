import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:society_gate/bloc/homepage_bloc.dart';
import 'package:society_gate/firebase_options.dart';

import 'auth/login_bloc/login_bloc.dart';
import 'auth/register_screen.dart';
import 'community/bloc/community_bloc.dart';
import 'constents/local_storage.dart';
import 'dashboard/members/member_bloc/members_bloc.dart';
import 'dashboard/visitors/visitor_view_bloc/visitors_view_bloc.dart';
import 'dashboard/visitors/visitors_bloc/visitors_bloc.dart';
import 'navigation_screen.dart';
import 'payments_screen/bloc/payments_bloc.dart';
import 'shops/bloc/dailyneeds_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await LocalStoragePref.instance!.initPrefBox();
  await dotenv.load(fileName: ".env");
  checkForUpdates();
  runApp(const MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

/// Function to check for updates at app startup
void checkForUpdates() async {
  try {
    AppUpdateInfo updateInfo = await InAppUpdate.checkForUpdate();

    if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
      if (updateInfo.immediateUpdateAllowed) {
        await InAppUpdate.performImmediateUpdate();
      } else if (updateInfo.flexibleUpdateAllowed) {
        await InAppUpdate.startFlexibleUpdate();
        await InAppUpdate.completeFlexibleUpdate();
      }
    }
  } catch (e) {
    log("Error checking for updates: $e");
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? isLoggedin;

  @override
  void initState() {
    super.initState();
    checkData();
  }

  void checkData() {
    isLoggedin = LocalStoragePref().getLoginBool();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (context) => LoginBloc()),
        BlocProvider<MembersBloc>(create: (context) => MembersBloc()),
        BlocProvider<VisitorsBloc>(create: (context) => VisitorsBloc()),
        BlocProvider<DailyneedsBloc>(create: (context) => DailyneedsBloc()),
        BlocProvider<PaymentsBloc>(create: (context) => PaymentsBloc()),
        BlocProvider<CommunityBloc>(create: (context) => CommunityBloc()),
        BlocProvider<VisitorsDetailBloc>(
            create: (context) => VisitorsDetailBloc()),
        BlocProvider<HomepageBloc>(create: (context) => HomepageBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
        home: isLoggedin == true
            ? const Navigationscreen()
            : const RegisterScreen(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
