import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:in_app_update/in_app_update.dart';

import 'auth/login_bloc/login_bloc.dart';
import 'auth/register_screen.dart';
import 'constents/local_storage.dart';
import 'dashboard/members/member_bloc/members_bloc.dart';
import 'dashboard/visitors/visitor_view_bloc/visitors_view_bloc.dart';
import 'dashboard/visitors/visitors_bloc/visitors_bloc.dart';
import 'navigation_screen.dart';
import 'shops/bloc/dailyneeds_bloc.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStoragePref.instance!.initPrefBox();
  await dotenv.load(fileName: ".env");
  checkForUpdates();
  runApp(const MyApp());
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
        BlocProvider<VisitorsDetailBloc>(
            create: (context) => VisitorsDetailBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
        home: isLoggedin == true
            ? const Navigationscreen()
            : const RegisterScreen(),
      ),
    );
  }
}
