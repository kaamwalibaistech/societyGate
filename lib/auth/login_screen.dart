import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

import '../constents/sizedbox.dart';
import 'login_bloc/login_bloc.dart';
import 'login_success.dart';
import 'register_member.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<LoginScreen> {
  final TextEditingController _mobileNoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) async {
        if (state is LoginLoadingState) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is LoginSuccessState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const LoginSuccess()),
          );
        } else if (state is LoginErrorState) {
          Navigator.of(context).pop();
          Fluttertoast.showToast(
            msg: state.errMsg,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: loginScreen(),
      ),
    );
  }

  Widget loginScreen() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 10),
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
                        color: Colors.deepPurple.shade400,
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
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 10),
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
                  if (_formKey.currentState!.validate()) {
                    context.read<LoginBloc>().add(
                          LoginButtonEvent(_mobileNoController.text,
                              _passwordController.text),
                        );
                  }
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
      ),
    );
  }
}
