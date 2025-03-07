import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:my_society/auth/login_bloc/login_bloc.dart';
import 'package:my_society/auth/login_success.dart';
import 'package:my_society/auth/network/login_api.dart';
import 'package:my_society/auth/register_member.dart';
import 'package:my_society/constents/sizedbox.dart';
import 'package:my_society/models/login_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<LoginScreen> {
  final TextEditingController _mobileNoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isPasswordHidden = false;
  LoginBloc? loginBloc;

  String? validateEmail(String? email) {
    RegExp emailRegEx = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
    final isEmailValid = emailRegEx.hasMatch(email ?? "");
    if (!isEmailValid) return "please  Enter a valid email";
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              // do stuff here based on BlocA's state
              state is LoginInitialState ||
                  state is LoginLoadingState ||
                  state is LoginSuccessState;
            },
            bloc: loginBloc,
            buildWhen: (previous, current) =>
                current is LoginInitialState ||
                current is LoginLoadingState ||
                current is LoginSuccessState,
            builder: (context, state) {
              if (state is LoginInitialState) {
                return LoginScreen();
              } else if (state is LoginSuccessState) {
                return Text("success");
              } else if (state is LoginErrorState) {
                return Text("Error");
              } else
                return Text("jhii");
            }));
  }

  Widget LoginScreen() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Center(
                child: Text(
              "Welcome back!",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.deepPurple[700]),
            )),
            sizedBoxH5(context),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.30,
              child: Lottie.asset("lib/assets/lottie_json/login.json"),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterMember()));
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                  Text(
                    "Register Here",
                    style: TextStyle(
                        color: Colors.deepPurpleAccent,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              child: TextFormField(
                validator: validateEmail,
                keyboardType: TextInputType.emailAddress,
                controller: _mobileNoController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 0.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 0.5),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  hintText: "Email ",
                  hintStyle: TextStyle(color: Colors.deepPurple[200]),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              child: TextFormField(
                keyboardType: TextInputType.visiblePassword,
                controller: _passwordController,
                obscureText: !isPasswordHidden,
                decoration: InputDecoration(
                  filled: true,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isPasswordHidden = !isPasswordHidden;
                      });
                    },
                    child: Icon(
                      isPasswordHidden
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.black54,
                    ),
                  ),
                  fillColor: Colors.white,
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 0.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 0.5),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  counterText: "",
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.deepPurple[200]),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Center(
              child: Text(
                "Forgot Password?",
                style: TextStyle(
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () async {
                context.read<LoginBloc>().add(
                      LoginButtonEvent(
                          _mobileNoController.text, _passwordController.text),
                    );
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.75,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(30)),
                child: const Center(
                    child: Text(
                  "Log In",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
