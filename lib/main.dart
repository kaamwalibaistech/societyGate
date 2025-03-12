import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_society/constents/local_storage.dart';
import 'package:my_society/models/login_model.dart';
import 'package:my_society/navigation_screen.dart';

import 'auth/login_bloc/login_bloc.dart';
import 'auth/register_screen.dart';
import 'dashboard/members/members_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStoragePref.init();
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
      providers: [BlocProvider<LoginBloc>(create: (context) => LoginBloc())],
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
