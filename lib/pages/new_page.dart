import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:social_media/bloc/list_bloc/list_bloc.dart';
import 'package:social_media/bloc/list_bloc/list_event.dart';
import 'package:social_media/bloc/list_bloc/list_state.dart';
import 'package:social_media/constants/enums.dart';
import 'package:social_media/constants/time_diff.dart';
import 'package:social_media/pages/details_page.dart';
import 'package:social_media/pages/login_page.dart';
import 'package:social_media/pages/post_page.dart';
import 'package:social_media/services/auth/auth_services.dart';

class NewPage extends StatefulWidget {
  const NewPage({super.key});

  @override
  State<NewPage> createState() => _NewPage();
}

class _NewPage extends State<NewPage> {
  final TextEditingController cont = TextEditingController();
  @override
  void initState() {
    context.read<ListBloc>().add(const GetListEvent());
    super.initState();
  }

  bool upVoted = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ALL POSTS',
          style: TextStyle(letterSpacing: 2),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: () {
                AuthServices().logout();
                Navigator.of(context).pushAndRemoveUntil(
                    PageTransition(
                        child: const LoginPage(),
                        type: PageTransitionType.leftToRight),
                    (_) => false);
              },
              icon: const Icon(Icons.login_outlined),
              label: const Text('LOGOUT'),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => const NewPage(),
        child: BlocBuilder<ListBloc, ListState>(
          buildWhen: (previous, current) =>
              previous.stateOfList != current.stateOfList,
          builder: (context, state) {
            if (state.stateOfList == StateOfList.loading ||
                state.stateOfList == StateOfList.adding) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                  itemCount: state.posts.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Navigator.of(context).push(PageTransition(
                          child: DetailsPage(details: state.posts[index]),
                          type: PageTransitionType.rightToLeft)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Column(
                            children: [
                              Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '@${state.posts[index]['madeBy']}',
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.blue),
                                      ),
                                      const SizedBox(height: 10),
                                      (state.posts[index]['content']
                                                  .toString()
                                                  .length >
                                              100)
                                          ? Text(
                                              '${state.posts[index]['content'].toString().substring(0, 100)}...',
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            )
                                          : Text(
                                              state.posts[index]['content']
                                                  .toString(),
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                      const SizedBox(height: 10),
                                      (state.posts[index]['tags'].length > 0)
                                          ? Column(
                                              children: [
                                                Container(
                                                  alignment: Alignment.topLeft,
                                                  height: 40,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: ListView.builder(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount: state
                                                          .posts[index]['tags']
                                                          .length,
                                                      itemBuilder: (context,
                                                          insideIndex) {
                                                        return Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 10),
                                                          child: ElevatedButton(
                                                              onPressed: () {},
                                                              child: Text(
                                                                // ignore: prefer_interpolation_to_compose_strings
                                                                '#' +
                                                                    state.posts[index]
                                                                            [
                                                                            'tags']
                                                                        [
                                                                        insideIndex],
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
                                      Container(
                                          margin:
                                              const EdgeInsets.only(left: 16),
                                          child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Text(
                                                DateTimeDifference().getDiff(
                                                    state.posts[index]
                                                        ['madeAt'],
                                                    DateTime.now()),
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ))),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const SizedBox(width: 20),
                                          Text(state.posts[index]['upvotes']
                                              .toString()),
                                          const SizedBox(width: 20),
                                          IconButton(
                                            onPressed: () {
                                              context.read<ListBloc>().add(
                                                  UpVoteEvent(index: index));
                                            },
                                            icon: const Icon(Icons.thumb_up),
                                          ),
                                          const SizedBox(width: 20),
                                          (state.posts[index]['open'] == true)
                                              ? const CircleAvatar(
                                                  backgroundColor: Colors.green,
                                                  radius: 5,
                                                )
                                              : const CircleAvatar(
                                                  backgroundColor: Colors.red,
                                                  radius: 5,
                                                ),
                                          const SizedBox(width: 5),
                                          (state.posts[index]['open'] == true)
                                              ? const Text('Open')
                                              : const Text('Closed'),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
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
