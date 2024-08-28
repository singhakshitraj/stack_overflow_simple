import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:social_media/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:social_media/bloc/sign_up_bloc/sign_up_event.dart';
import 'package:social_media/bloc/sign_up_bloc/sign_up_state.dart';
import 'package:social_media/constants/enums.dart';
import 'package:social_media/pages/login_page.dart';
import 'package:social_media/pages/main_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController username = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController name = TextEditingController();
  @override
  void initState() {
    username.clear();
    pass.clear();
    name.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SignUpBloc, SignUpState>(
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
                      context.read<SignUpBloc>().add(SignOut());
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
                            Icons.accessibility_outlined,
                            size: 250,
                          ),
                          const Center(
                            child: Text(
                              'WELCOME BACK!!',
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                          const Text(
                            'Sign Up To Continue',
                          ),
                          const SizedBox(height: 20),
                          const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Enter Your Name Here - ',
                              )),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: name,
                            decoration: InputDecoration(
                                hintText: 'Enter Name Here',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25))),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Enter Your Email Here - ',
                              )),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: username,
                            decoration: InputDecoration(
                                hintText: 'Enter Your Email Here',
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
                                hintText: 'Enter Your Password Here',
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
                                          type: PageTransitionType
                                              .leftToRightWithFade,
                                          child: const LoginPage()),
                                      (_) => false);
                                },
                                child: const Text(
                                  'Already A User? Login Here',
                                  style: TextStyle(color: Colors.blue),
                                )),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                              onPressed: () {
                                context.read<SignUpBloc>().add(SignUp(
                                    name: name.text,
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
                                  const Text('Sign-Up'),
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
