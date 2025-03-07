import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_society/models/login_model.dart';

import 'auth/login_bloc/login_bloc.dart';
import 'auth/register_screen.dart';

Future main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<LoginBloc>(create: (context) => LoginBloc())],
      child: MaterialApp(
        theme: ThemeData(),
        home: const RegisterScreen(),
      ),
    );
  }
}
