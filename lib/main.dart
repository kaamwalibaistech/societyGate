import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_society/constents/local_storage.dart';
import 'package:my_society/dashboard/members/member_bloc/members_bloc.dart';
import 'package:my_society/dashboard/visitors/visitor_view_bloc/visitors_view_bloc.dart';
import 'package:my_society/dashboard/visitors/visitors_bloc/visitors_bloc.dart';
import 'package:my_society/navigation_screen.dart';

import 'auth/login_bloc/login_bloc.dart';
import 'auth/register_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStoragePref.instance!.initPrefBox();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
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
