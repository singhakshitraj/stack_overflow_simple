import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:social_media/bloc/login_bloc/login_bloc.dart';
import 'package:social_media/bloc/login_bloc/login_event.dart';
import 'package:social_media/bloc/login_bloc/login_state.dart';
import 'package:social_media/constants/enums.dart';
import 'package:social_media/constants/themes.dart';
import 'package:social_media/pages/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController username = TextEditingController();
    TextEditingController pass = TextEditingController();
    return Scaffold(
      body: BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) =>
            previous.loadingState != current.loadingState,
        builder: (context, state) {
          if (state.loadingState == LoadingState.done) {
            return const Center(child: Text('Done'));
          } else if (state.loadingState == LoadingState.error) {
            if (kDebugMode) {
              print(state.message.toString());
            }
            return const Center(child: Text('Error'));
          } else {
            return SingleChildScrollView(
              child: Center(
                child: Container(
                  margin: const EdgeInsets.all(40),
                  width: min(MediaQuery.of(context).size.width * 0.8, 350),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      color: const Color.fromARGB(255, 40, 39, 39),
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
                            Center(
                              child: Text(
                                'WELCOME BACK!!',
                                style: whiteText.copyWith(fontSize: 30),
                              ),
                            ),
                            Text(
                              'Login To Continue',
                              style: whiteText,
                            ),
                            const SizedBox(height: 20),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Enter Your Email Here - ',
                                  style: whiteText,
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
                            Align(
                                alignment: Alignment.bottomLeft,
                                child: Text('Enter Password Here - ',
                                    style: whiteText)),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: pass,
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: 'Enter Password Here',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25))),
                            ),
                            const SizedBox(height: 5),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                            PageTransition(type: PageTransitionType.rightToLeft,child:  const SignUpPage()));
                                  },
                                  child: const Text(
                                    'New User? Register Here',
                                    style: TextStyle(color: Colors.blue),
                                  )),
                            ),
                            const SizedBox(height: 10),
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
                                child:
                                    (state.loadingState == LoadingState.loading)
                                        ? const CircularProgressIndicator()
                                        : const Text('Login'))
                          ],
                        ),
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
