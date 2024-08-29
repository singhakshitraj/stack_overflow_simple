import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:social_media/constants/themes.dart';
import 'package:social_media/pages/lists/list_page.dart';

import '../bloc/login_bloc/login_bloc.dart';
import '../bloc/login_bloc/login_event.dart';
import '../bloc/sign_up_bloc/sign_up_bloc.dart';
import '../bloc/sign_up_bloc/sign_up_event.dart';
import '../pages/auth/login_page.dart';

Widget appDrawer(BuildContext context) => Drawer(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20)),
            child: Image.asset(
              'lib/assets/appIcon.jpg',
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: ListTile(
                      leading: const Icon(CupertinoIcons.home),
                      title: Text(
                        'HOME',
                        style: spacing(),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushAndRemoveUntil(
                        PageTransition(
                            child: const ListPage(parameter: 'myPosts'),
                            type: PageTransitionType.rightToLeft),
                        (route) => route.isFirst);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: ListTile(
                      leading: const Icon(CupertinoIcons.doc),
                      title: Text(
                        'MY POSTS',
                        style: spacing(),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushAndRemoveUntil(
                        PageTransition(
                            child: const ListPage(parameter: 'liked'),
                            type: PageTransitionType.rightToLeft),
                        (route) => route.isFirst);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: ListTile(
                      leading: const Icon(CupertinoIcons.heart_fill),
                      title: Text(
                        'LIKED',
                        style: spacing(),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushAndRemoveUntil(
                        PageTransition(
                            child: const ListPage(parameter: 'bookmarked'),
                            type: PageTransitionType.rightToLeft),
                        (route) => route.isFirst);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: ListTile(
                      leading: const Icon(CupertinoIcons.bookmark_fill),
                      title: Text(
                        'BOOKMARKED',
                        style: spacing(),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    context.read<LoginBloc>().add(LogoutEvent());
                    context.read<SignUpBloc>().add(SignOut());
                    Navigator.of(context).pushAndRemoveUntil(
                        PageTransition(
                            child: const LoginPage(),
                            type: PageTransitionType.rightToLeft),
                        (_) => false);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: ListTile(
                      leading: const Icon(Icons.logout_outlined),
                      title: Text(
                        'LOGOUT',
                        style: spacing(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
