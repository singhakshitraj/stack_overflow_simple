import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:social_media/bloc/sign_up_bloc/sign_up_event.dart';
import 'package:social_media/bloc/sign_up_bloc/sign_up_state.dart';
import 'package:social_media/constants/enums.dart';
import 'package:social_media/constants/themes.dart';
import 'package:social_media/pages/new_page.dart';

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
            return const NewPage();
          } else if (state.loadingState == LoadingState.error) {
            return Center(child: Text(state.message.toString()));
          } else {
            return SingleChildScrollView(
              child: Center(
                child: Container(
                  margin: const EdgeInsets.all(40),
                  width: min(MediaQuery.of(context).size.width * 0.8, 350),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
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
                              'Sign Up To Continue',
                              style: whiteText,
                            ),
                            const SizedBox(height: 20),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Enter Your Name Here - ',
                                  style: whiteText,
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
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Enter Your Age Here - ',
                                  style: whiteText,
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
                                  hintText: 'Enter Your Email Here',
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
                                  hintText: 'Enter Your Password Here',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25))),
                            ),
                            const SizedBox(height: 5),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: GestureDetector(
                                  onTap: () => Navigator.of(context).pop(),
                                  child: const Text(
                                    'Already A User? Login Here',
                                    style: TextStyle(color: Colors.blue),
                                  )),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                                onPressed: () {
                                  context.read<SignUpBloc>().add(SignUp(
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
                                        : const Text('Sign-Up'))
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
