import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:social_media/bloc/saved_items_bloc/saved_bloc.dart';
import 'package:social_media/bloc/saved_items_bloc/saved_event.dart';
import 'package:social_media/bloc/saved_items_bloc/saved_state.dart';
import 'package:social_media/constants/enums.dart';

import '../../constants/time_diff.dart';
import '../details_page.dart';

class ListPage extends StatefulWidget {
  final String parameter;
  const ListPage({
    super.key,
    required this.parameter,
  });

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  void initState() {
    context.read<SavedBloc>().add(LoadSavedList(parameter: widget.parameter));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.parameter.toUpperCase()),
      ),
      body: BlocBuilder<SavedBloc, SavedState>(builder: (context, state) {
        if (state.status == TileStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status == TileStatus.error) {
          return Center(
              child: Text(
            'No Items In ${widget.parameter.toLowerCase()}. Add More Items From Postpage',
          ));
        } else {
          return Center(
            child: SizedBox(
              width: min(600, MediaQuery.of(context).size.width),
              child: ListView.builder(
                  itemCount: state.requiredPosts.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Navigator.of(context).push(PageTransition(
                          child:
                              DetailsPage(details: state.requiredPosts[index]),
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
                                            '@${state.requiredPosts[index]['madeBy']}',
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
                                          (state.requiredPosts[index]['open'] ==
                                                  true)
                                              ? const CircleAvatar(
                                                  backgroundColor: Colors.green,
                                                  radius: 5,
                                                )
                                              : const CircleAvatar(
                                                  backgroundColor: Colors.red,
                                                  radius: 5,
                                                ),
                                          const SizedBox(width: 10),
                                          (state.requiredPosts[index]['open'] ==
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
                                              alignment: Alignment.bottomLeft,
                                              child: Text(
                                                DateTimeDifference().getDiff(
                                                    state.requiredPosts[index]
                                                        ['madeAt'],
                                                    DateTime.now()),
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              )),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        state.requiredPosts[index]['title']
                                            .toString(),
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      const SizedBox(height: 10),
                                      (state.requiredPosts[index]['content']
                                                  .toString()
                                                  .length >
                                              200)
                                          ? Text(
                                              '${state.requiredPosts[index]['content'].toString().substring(0, 200)}...',
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            )
                                          : Text(
                                              state.requiredPosts[index]
                                                      ['content']
                                                  .toString(),
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            ),
                                      const SizedBox(height: 10),
                                      (state.requiredPosts[index]['tags']
                                                  .length >
                                              0)
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
                                                          .requiredPosts[index]
                                                              ['tags']
                                                          .length,
                                                      itemBuilder: (context,
                                                          insideIndex) {
                                                        return Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 10),
                                                          child: OutlinedButton(
                                                              onPressed: () {},
                                                              child: Text(
                                                                // ignore: prefer_interpolation_to_compose_strings
                                                                '#' +
                                                                    state.requiredPosts[index]
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
      }),
    );
  }
}
