import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/getwidget.dart';
import 'package:social_media/bloc/details_bloc/details_bloc.dart';
import 'package:social_media/bloc/details_bloc/details_event.dart';
import 'package:social_media/bloc/status_bloc/status_event.dart';
import 'package:social_media/bloc/status_bloc/status_state.dart';
import 'package:social_media/constants/enums.dart';
import 'package:social_media/constants/themes.dart';
import 'package:social_media/services/auth/auth_services.dart';
import '../bloc/details_bloc/details_state.dart';
import '../bloc/status_bloc/status_bloc.dart';
import '../constants/time_diff.dart';

class DetailsPage extends StatefulWidget {
  final Map<String, dynamic> details;
  const DetailsPage({super.key, required this.details});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    context.read<DetailsBloc>().add(GetDataEvent(id: widget.details['id']));
    context
        .read<StatusBloc>()
        .add(GetInitialDataEvent(postId: widget.details['id']));
    super.initState();
  }

  final TextEditingController _textF = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Details'),
          elevation: 10,
          centerTitle: true,
          actions: [
            BlocBuilder<DetailsBloc, DetailsState>(
              builder: (context, state) {
                if (state.data['madeBy'] == AuthServices().username) {
                  final bool isOpen = state.data['open'] == true;
                  return PopupMenuButton(
                      itemBuilder: (context) => [
                            PopupMenuItem(
                              child: (isOpen)
                                  ? const Text('Close Issue')
                                  : const Text('Open Issue'),
                              onTap: () {
                                (isOpen)
                                    ? context.read<DetailsBloc>().add(
                                        CloseIssueEvent(id: state.data['id']))
                                    : context.read<DetailsBloc>().add(
                                        OpenIssueEvent(id: state.data['id']));
                              },
                            )
                          ]);
                } else {
                  return const Text('');
                }
              },
            ),
          ]),
      body: BlocBuilder<DetailsBloc, DetailsState>(
        builder: (context, state) {
          if (state.state == StateOfList.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.state == StateOfList.adding) {
            return const Center(child: Text('Please Wait ...'));
          } else {
            return SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: min(600, MediaQuery.of(context).size.width),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      ListTile(
                        title: Text(
                          // ignore: prefer_interpolation_to_compose_strings
                          '@' + state.data['madeBy'],
                          style: const TextStyle(color: Colors.blue),
                        ),
                        subtitle: Row(
                          children: [
                            Text(DateTimeDifference()
                                .getDiff(state.data['madeAt'], DateTime.now())),
                            const SizedBox(width: 40),
                            (state.data['open'] == true)
                                ? const CircleAvatar(
                                    backgroundColor: Colors.green,
                                    radius: 5,
                                  )
                                : const CircleAvatar(
                                    backgroundColor: Colors.red,
                                    radius: 5,
                                  ),
                            const SizedBox(width: 10),
                            (state.data['open'] == true)
                                ? const Text('Open')
                                : const Text('Closed'),
                          ],
                        ),
                      ),
                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.data['title'].toString(),
                                style: const TextStyle(fontSize: 18),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                state.data['content'].toString(),
                                style: const TextStyle(fontSize: 15),
                              ),
                              const SizedBox(height: 15),
                              (state.data['tags'].length > 0)
                                  ? Align(
                                      alignment: Alignment.topLeft,
                                      child: Wrap(
                                        spacing: 10,
                                        runSpacing: 7.5,
                                        children: List.generate(
                                            state.data['tags'].length, (index) {
                                          return OutlinedButton(
                                              onPressed: () {},
                                              child: Text(
                                                  state.data['tags'][index]));
                                        }),
                                      ),
                                    )
                                  : SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 1,
                                    ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 60,
                        child: BlocBuilder<StatusBloc, StatusState>(
                          builder: (context, state) {
                            if (state.tileStatus == TileStatus.loading ||
                                state.tileStatus == TileStatus.notInitiated) {
                              return const SizedBox(
                                  height: 60,
                                  child: Center(
                                    child: Text(
                                        'Please Wait While Status Bar Is Being Loaded ... '),
                                  ));
                            } else if (state.tileStatus == TileStatus.error) {
                              return const SizedBox(
                                height: 60,
                                child: Center(
                                    child: Text(
                                        'Error Occurred While Doing Operation')),
                              );
                            } else {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Expanded(flex: 1, child: SizedBox()),
                                  Expanded(
                                    flex: 20,
                                    child: SizedBox(
                                      height: 60,
                                      child: (state.isLiked!)
                                          ? ElevatedButton(
                                              style: buttonStyle(),
                                              onPressed: () async {
                                                await GFToast.showToast(
                                                    toastPosition:
                                                        GFToastPosition.BOTTOM,
                                                    'Applying Changes...',
                                                    context);
                                                context.read<StatusBloc>().add(
                                                    RemoveFromLikedEvent(
                                                        postId: widget
                                                            .details['id'],
                                                        isBookmarked: state
                                                            .isBookmarked!));
                                              },
                                              child: const Row(
                                                children: [
                                                  Icon(CupertinoIcons
                                                      .heart_fill),
                                                  SizedBox(width: 10),
                                                  Text('LIKED'),
                                                ],
                                              ))
                                          : OutlinedButton(
                                              style: buttonStyle(),
                                              onPressed: () async {
                                                await GFToast.showToast(
                                                    toastPosition:
                                                        GFToastPosition.BOTTOM,
                                                    'Applying Changes...',
                                                    context);
                                                context.read<StatusBloc>().add(
                                                    AddToLikedEvent(
                                                        postId: widget
                                                            .details['id'],
                                                        isBookmarked: state
                                                            .isBookmarked!));
                                              },
                                              child: const Row(
                                                children: [
                                                  Icon(CupertinoIcons.heart),
                                                  SizedBox(width: 20),
                                                  Text('LIKE'),
                                                ],
                                              )),
                                    ),
                                  ),
                                  const Expanded(flex: 1, child: SizedBox()),
                                  Expanded(
                                    flex: 20,
                                    child: SizedBox(
                                      height: 60,
                                      child: (state.isBookmarked!)
                                          ? ElevatedButton(
                                              style: buttonStyle(),
                                              onPressed: () async {
                                                await GFToast.showToast(
                                                    toastPosition:
                                                        GFToastPosition.BOTTOM,
                                                    'Applying Changes...',
                                                    context);
                                                context.read<StatusBloc>().add(
                                                    RemoveFromBookmarkEvent(
                                                        postId: widget
                                                            .details['id'],
                                                        isLiked:
                                                            state.isLiked!));
                                              },
                                              child: const Row(
                                                children: [
                                                  Icon(CupertinoIcons
                                                      .bookmark_fill),
                                                  SizedBox(width: 10),
                                                  Text('BOOKMARKED'),
                                                ],
                                              ))
                                          : OutlinedButton(
                                              style: buttonStyle(),
                                              onPressed: () async {
                                                await GFToast.showToast(
                                                    toastPosition:
                                                        GFToastPosition.BOTTOM,
                                                    'Applying Changes...',
                                                    context);
                                                context.read<StatusBloc>().add(
                                                    AddToBookmarkEvent(
                                                        postId: widget
                                                            .details['id'],
                                                        isLiked:
                                                            state.isLiked!));
                                              },
                                              child: const Row(
                                                children: [
                                                  Icon(CupertinoIcons.bookmark),
                                                  SizedBox(width: 20),
                                                  Text('BOOKMARK'),
                                                ],
                                              )),
                                    ),
                                  ),
                                  const Expanded(flex: 1, child: SizedBox()),
                                ],
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text('Comments'),
                      const SizedBox(
                        height: 20,
                      ),
                      ListView.builder(
                          itemCount: state.data['comments'].length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 0,
                              margin: const EdgeInsets.only(
                                  left: 10, right: 10, top: 3),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                leading: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Image.asset('lib/assets/guest.png'),
                                ),
                                title: Text(
                                  state.data['comments'][index]['madeBy']
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.blue),
                                ),
                                subtitle: Text(
                                  state.data['comments'][index]['content']
                                      .toString(),
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await showModalBottomSheet(
              context: context,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.topCenter,
                        child: Text('POST A COMMENT'),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _textF,
                        minLines: 5,
                        maxLines: null,
                        decoration: const InputDecoration(
                            hintText: 'Enter Your Message Here...'),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                            iconAlignment: IconAlignment.end,
                            onPressed: () {
                              Map<String, dynamic> comment = {
                                'content': _textF.text,
                              };
                              context.read<DetailsBloc>().add(AddCommentEvent(
                                  comment: comment, id: widget.details['id']));
                              setState(() {
                                Navigator.of(context).pop();
                              });
                            },
                            child: const Text('POST')),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
