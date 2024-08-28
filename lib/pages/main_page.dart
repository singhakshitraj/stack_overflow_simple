import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:social_media/bloc/post_bloc/post_bloc.dart';
import 'package:social_media/bloc/post_bloc/post_event.dart';
import 'package:social_media/bloc/post_bloc/post_state.dart';
import 'package:social_media/bloc/login_bloc/login_bloc.dart';
import 'package:social_media/bloc/login_bloc/login_event.dart';
import 'package:social_media/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:social_media/bloc/sign_up_bloc/sign_up_event.dart';
import 'package:social_media/constants/enums.dart';
import 'package:social_media/constants/time_diff.dart';
import 'package:social_media/pages/details_page.dart';
import 'package:social_media/pages/login_page.dart';
import 'package:social_media/pages/post_page.dart';
import 'dart:math';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  final TextEditingController cont = TextEditingController();
  @override
  void initState() {
    context.read<PostBloc>().add(const GetPostEvent());
    super.initState();
  }

  bool upVoted = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: const Text(
          'ALL POSTS',
          style: TextStyle(letterSpacing: 2),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: () async {
                context.read<LoginBloc>().add(LogoutEvent());
                context.read<SignUpBloc>().add(SignOut());
                Navigator.of(context).pushAndRemoveUntil(
                    PageTransition(
                        child: const LoginPage(),
                        type: PageTransitionType.rightToLeft),
                    (_) => false);
              },
              icon: const Icon(Icons.login_outlined),
              label: const Text('LOGOUT'),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => context.read<PostBloc>().add(RefreshEvent()),
        child: BlocBuilder<PostBloc, PostState>(
          buildWhen: (previous, current) =>
              previous.stateOfList != current.stateOfList,
          builder: (context, state) {
            if (state.stateOfList == StateOfList.loading ||
                state.stateOfList == StateOfList.adding) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Center(
                child: SizedBox(
                  width: min(600, MediaQuery.of(context).size.width),
                  child: ListView.builder(
                      itemCount: state.posts.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => Navigator.of(context).push(
                              PageTransition(
                                  child:
                                      DetailsPage(details: state.posts[index]),
                                  type: PageTransitionType.rightToLeft)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Column(
                                children: [
                                  Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                '@${state.posts[index]['madeBy']}',
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.blue),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                color: Colors.black,
                                                height: 10,
                                                width: 1,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              (state.posts[index]['open'] ==
                                                      true)
                                                  ? const CircleAvatar(
                                                      backgroundColor:
                                                          Colors.green,
                                                      radius: 5,
                                                    )
                                                  : const CircleAvatar(
                                                      backgroundColor:
                                                          Colors.red,
                                                      radius: 5,
                                                    ),
                                              const SizedBox(width: 10),
                                              (state.posts[index]['open'] ==
                                                      true)
                                                  ? const Text('Open')
                                                  : const Text('Closed'),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                color: Colors.black,
                                                height: 10,
                                                width: 1,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Text(
                                                    DateTimeDifference()
                                                        .getDiff(
                                                            state.posts[index]
                                                                ['madeAt'],
                                                            DateTime.now()),
                                                    style: const TextStyle(
                                                        fontSize: 12),
                                                  )),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            state.posts[index]['title']
                                                .toString(),
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                          const SizedBox(height: 10),
                                          (state.posts[index]['content']
                                                      .toString()
                                                      .length >
                                                  100)
                                              ? Text(
                                                  '${state.posts[index]['content'].toString().substring(0, 200)}...',
                                                  style: const TextStyle(
                                                      fontSize: 14),
                                                )
                                              : Text(
                                                  state.posts[index]['content']
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 14),
                                                ),
                                          const SizedBox(height: 10),
                                          (state.posts[index]['tags'].length >
                                                  0)
                                              ? Column(
                                                  children: [
                                                    Container(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      height: 40,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: ListView.builder(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemCount: state
                                                              .posts[index]
                                                                  ['tags']
                                                              .length,
                                                          itemBuilder: (context,
                                                              insideIndex) {
                                                            return Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      right:
                                                                          10),
                                                              child:
                                                                  OutlinedButton(
                                                                      onPressed:
                                                                          () {},
                                                                      child:
                                                                          Text(
                                                                        // ignore: prefer_interpolation_to_compose_strings
                                                                        '#' +
                                                                            state.posts[index]['tags'][insideIndex],
                                                                      )),
                                                            );
                                                          }),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                  ],
                                                )
                                              : const SizedBox(height: 1),
                                          const SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(PageTransition(
              child: const PostPage(), type: PageTransitionType.rightToLeft));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
