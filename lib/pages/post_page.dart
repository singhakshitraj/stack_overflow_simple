import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/bloc/list_bloc/list_bloc.dart';
import 'package:social_media/bloc/list_bloc/list_event.dart';
import 'package:social_media/services/post/post_format.dart';
import 'package:social_media/services/post/post_services.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final TextEditingController _content = TextEditingController();
  final TextEditingController _hashtags = TextEditingController();
  List<String> hashtags = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post By - guest'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: min(400, MediaQuery.of(context).size.width * 0.8),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Enter Your Message Here...'),
                    const SizedBox(height: 30),
                    TextField(
                      maxLength: 5000,
                      minLines: 5,
                      maxLines: null,
                      controller: _content,
                      decoration: const InputDecoration(
                          hintText: 'Write Your Mesage Here',
                          enabledBorder:
                              OutlineInputBorder(borderSide: BorderSide.none)),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                        'Enter Hashtags Here And Press + Icon To Add...'),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: TextField(
                            controller: _hashtags,
                            maxLength: 20,
                            decoration: const InputDecoration(
                                hintText: 'Enter Hashtags Here',
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none)),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            flex: 1,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (_hashtags.text != '') {
                                    setState(() {
                                      if (hashtags.contains(
                                              _hashtags.text.toLowerCase()) !=
                                          true) {
                                        hashtags
                                            .add(_hashtags.text.toLowerCase());
                                      }
                                      _hashtags.clear();
                                    });
                                  }
                                },
                                child: const Icon(Icons.add)))
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 30,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) => const Divider(
                                height: 5,
                              ),
                          itemCount: hashtags.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 100,
                              child: ElevatedButton.icon(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    setState(() {
                                      hashtags.remove(hashtags[index]);
                                    });
                                  },
                                  label: Text(hashtags[index])),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ListBloc>().add(AddToListEvent(
              post: PostFormat().toPost(
                  {'content': _content.text, 'tags': hashtags.toList()})));
          Navigator.of(context).pop();
        },
        child: const Icon(Icons.chevron_right_sharp),
      ),
    );
  }
}
