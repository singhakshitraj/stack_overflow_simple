import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:social_media/bloc/login_bloc/login_bloc.dart';
import 'package:social_media/bloc/login_bloc/login_event.dart';
import 'package:social_media/bloc/login_bloc/login_state.dart';
import 'package:social_media/constants/enums.dart';
import 'package:social_media/pages/main_page.dart';
import 'package:social_media/pages/auth/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController pass = TextEditingController();
  @override
  void initState() {
    username.clear();
    pass.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) =>
            previous.loadingState != current.loadingState,
        builder: (context, state) {
          if (state.loadingState == LoadingState.done) {
            return const MainPage();
          } else if (state.loadingState == LoadingState.error) {
            return AlertDialog(
              content: const Text('Invalid Credentials. Try Again...'),
              actions: [
                TextButton(
                    onPressed: () {
                      context.read<LoginBloc>().add(LogoutEvent());
                    },
                    child: const Text('OKAY!!')),
              ],
            );
          } else {
            return SingleChildScrollView(
              child: Center(
                child: Container(
                  margin: const EdgeInsets.all(40),
                  width: min(MediaQuery.of(context).size.width * 0.9, 450),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 50),
                          const Icon(
                            Icons.person,
                            size: 250,
                          ),
                          const Center(
                            child: Text(
                              'WELCOME BACK!!',
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                          const Text(
                            'Login To Continue',
                          ),
                          const SizedBox(height: 20),
                          const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Enter Your Email Here - ',
                              )),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: username,
                            decoration: InputDecoration(
                                hintText: 'Enter Email Here',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25))),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                'Enter Password Here - ',
                              )),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: pass,
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: 'Enter Password Here',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25))),
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: const SignUpPage()),
                                      (_) => false);
                                },
                                child: const Text(
                                  'New User? Register Here',
                                  style: TextStyle(color: Colors.blue),
                                )),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                              onPressed: () {
                                context.read<LoginBloc>().add(Loggingin(
                                    userName: username.text,
                                    password: pass.text));
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              child: switch (state.loadingState) {
                                LoadingState.loading => const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(),
                                  ),
                                LoadingState.done => const MainPage(),
                                LoadingState.error => const Text('Error'),
                                LoadingState.notInitiated =>
                                  const Text('Login'),
                              })
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
