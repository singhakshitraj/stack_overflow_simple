import 'dart:math';

import 'package:flutter/material.dart';
import 'package:social_media/services/auth/auth_services.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: min(400, MediaQuery.of(context).size.width - 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 5),
              const Text('Email'),
              const SizedBox(height: 5),
              TextFormField(
                initialValue: AuthServices().email.toString(),
                enabled: false,
              ),
              const SizedBox(height: 5),
              const Text('Username'),
              const SizedBox(height: 5),
              TextFormField(
                initialValue: AuthServices().username.toString(),
                enabled: false,
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
