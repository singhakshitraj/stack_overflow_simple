import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:social_media/constants/push_buttons.dart';

import '../bloc/login_bloc/login_bloc.dart';
import '../bloc/login_bloc/login_event.dart';
import '../bloc/sign_up_bloc/sign_up_bloc.dart';
import '../bloc/sign_up_bloc/sign_up_event.dart';
import '../pages/auth/login_page.dart';
import '../pages/lists/list_page.dart';
import '../pages/post_page.dart';

Widget accountFunctions(BuildContext context) {
  return Wrap(
    children: [
      PushButton().displayButton(
          'lib/assets/raise_complaint.png',
          'Raise A Complaint',
          () => Navigator.of(context).push(PageTransition(
              child: const PostPage(), type: PageTransitionType.rightToLeft))),
      PushButton().displayButton(
          'lib/assets/my_complaints.png',
          'My Complaints',
          () => Navigator.of(context).push(PageTransition(
              child: const ListPage(parameter: 'myPosts'),
              type: PageTransitionType.rightToLeft))),
      PushButton().displayButton(
          'lib/assets/settings.png',
          'Settings',
          () => Navigator.of(context).push(PageTransition(
              child: const PostPage(), type: PageTransitionType.rightToLeft))),
      PushButton().displayButton(
          'lib/assets/liked.png',
          'Liked Posts',
          () => Navigator.of(context).push(PageTransition(
              child: const ListPage(parameter: 'liked'),
              type: PageTransitionType.rightToLeft))),
      PushButton().displayButton(
          'lib/assets/bookmarked.png',
          'Bookmarked Posts',
          () => Navigator.of(context).push(PageTransition(
              child: const ListPage(parameter: 'bookmarked'),
              type: PageTransitionType.rightToLeft))),
      PushButton().displayButton(
        'lib/assets/logout.png',
        'Logout',
        () {
          context.read<LoginBloc>().add(LogoutEvent());
          context.read<SignUpBloc>().add(SignOut());
          Navigator.of(context).pushAndRemoveUntil(
              PageTransition(
                  child: const LoginPage(),
                  type: PageTransitionType.rightToLeft),
              (_) => false);
        },
      )
    ],
  );
}
