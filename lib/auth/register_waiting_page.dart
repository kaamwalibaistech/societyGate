import 'package:flutter/material.dart';
import 'package:society_gate/models/admin_register_model.dart';

class RegisterWaitingPage extends StatelessWidget {
  final AdminRegister? data;
  const RegisterWaitingPage({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("${data?.message ?? ""}"),
    );
  }
}
