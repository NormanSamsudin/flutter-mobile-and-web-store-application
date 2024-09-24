import 'package:flutter/material.dart';
import 'package:mobile_application_store/controllers/auth_controller.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});
  final AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              await _authController.signOutUsers(context: context);
            },
            child: Text('Sign out')),
      ),
    );
  }
}
