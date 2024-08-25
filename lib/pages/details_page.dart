import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/bloc/details_bloc/details_bloc.dart';
import 'package:social_media/bloc/details_bloc/details_event.dart';
import 'package:social_media/constants/enums.dart';
import 'package:social_media/services/auth/auth_services.dart';

import '../bloc/details_bloc/details_state.dart';
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
                                child: TextButton(
                              child: (isOpen)
                                  ? const Text('Close Issue')
                                  : const Text('Open Issue'),
                              onPressed: () {
                                (isOpen)
                                    ? context.read<DetailsBloc>().add(
                                        CloseIssueEvent(id: state.data['id']))
                                    : context.read<DetailsBloc>().add(
                                        OpenIssueEvent(id: state.data['id']));
                                Navigator.pop(context);
                              },
                            ))
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
                        // ignore: prefer_interpolation_to_compose_strings
                        title: Text('Posted By - ' + state.data['madeBy']),
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
                              Text(state.data['content'].toString()),
                              const SizedBox(height: 30),
                              (state.data['tags'].length > 0)
                                  ? Align(
                                      alignment: Alignment.topLeft,
                                      child: Wrap(
                                        spacing: 10,
                                        runSpacing: 7.5,
                                        children: List.generate(
                                            state.data['tags'].length, (index) {
                                          return ElevatedButton(
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
                              margin: const EdgeInsets.all(10),
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
                              /*PostServices().postComments(widget.details['id'],
                                  PostFormat().toComment(comment));*/
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
