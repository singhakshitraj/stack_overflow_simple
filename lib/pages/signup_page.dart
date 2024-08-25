import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:social_media/bloc/sign_up_bloc/sign_up_event.dart';
import 'package:social_media/bloc/sign_up_bloc/sign_up_state.dart';
import 'package:social_media/constants/enums.dart';
import 'package:social_media/pages/main_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController username = TextEditingController();
    TextEditingController pass = TextEditingController();
    return Scaffold(
      body: BlocBuilder<SignUpBloc, SignUpState>(
        buildWhen: (previous, current) =>
            previous.loadingState != current.loadingState,
        builder: (context, state) {
          if (state.loadingState == LoadingState.done) {
            return const MainPage();
          } else if (state.loadingState == LoadingState.error) {
            return Center(child: Text(state.message.toString()));
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
                                'Enter Your Age Here - ',
                              )),
                          const SizedBox(height: 10),
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: 'Enter Age Here',
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
                                onTap: () => Navigator.of(context).pop(),
                                child: const Text(
                                  'Already A User? Login Here',
                                  style: TextStyle(color: Colors.blue),
                                )),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                              onPressed: () {
                                context.read<SignUpBloc>().add(SignUp(
                                    userName: username.text,
                                    password: pass.text));
                                print(FirebaseAuth
                                    .instance.currentUser?.displayName);
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              child:
                                  (state.loadingState == LoadingState.loading)
                                      ? const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: CircularProgressIndicator(),
                                        )
                                      : const Text('Sign-Up'))
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
