import 'dart:math';
import 'package:getwidget/getwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/bloc/list_bloc/list_bloc.dart';
import 'package:social_media/bloc/list_bloc/list_event.dart';
import 'package:social_media/services/auth/auth_services.dart';
import 'package:social_media/services/post/post_format.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final TextEditingController _content = TextEditingController();
  final TextEditingController _hashtags = TextEditingController();
  final TextEditingController _title = TextEditingController();
  List<String> hashtags = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post By - ${AuthServices().username ?? 'Guest'}'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: min(500, MediaQuery.of(context).size.width),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 5),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GFAccordion(
                        textStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary),
                        collapsedTitleBackgroundColor:
                            Theme.of(context).colorScheme.surfaceTint,
                        titleBorderRadius: BorderRadius.circular(10),
                        contentBackgroundColor:
                            Theme.of(context).colorScheme.onSecondary,
                        expandedTitleBackgroundColor:
                            Theme.of(context).colorScheme.surfaceTint,
                        title: '\t\t\tMust Read Instructions',
                        content:
                            ' \t\t* Multiple Hashtags Accepted.\n \t\t* All Unsaved Changes will be discarded.\n \t\t* Make Sure To Add The hashtag before posting.'),
                    const SizedBox(height: 20),
                    const Align(
                        alignment: Alignment.topLeft,
                        child: Text('Enter Your Title Here...')),
                    const SizedBox(height: 10),
                    TextField(
                      maxLength: 100,
                      minLines: 2,
                      maxLines: null,
                      controller: _title,
                      decoration: const InputDecoration(
                          hintText: 'Write Your Title Here',
                          enabledBorder:
                              OutlineInputBorder(borderSide: BorderSide.none)),
                    ),
                    const SizedBox(height: 10),
                    const Align(
                        alignment: Alignment.topLeft,
                        child: Text('Enter Your Message Here...')),
                    const SizedBox(height: 10),
                    TextField(
                      maxLength: 5000,
                      minLines: 4,
                      maxLines: null,
                      controller: _content,
                      decoration: const InputDecoration(
                          hintText: 'Write Your Message Here',
                          enabledBorder:
                              OutlineInputBorder(borderSide: BorderSide.none)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                          'Enter Hashtags Here And Press + Icon To Add...'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _hashtags,
                      maxLength: 20,
                      decoration: const InputDecoration(
                          hintText: 'Enter Hashtags Here',
                          enabledBorder:
                              OutlineInputBorder(borderSide: BorderSide.none)),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_hashtags.text != '') {
                            setState(() {
                              if (hashtags
                                      .contains(_hashtags.text.toLowerCase()) !=
                                  true) {
                                hashtags.add(_hashtags.text.toLowerCase());
                              }
                              _hashtags.clear();
                            });
                          }
                        },
                        child: const Icon(Icons.add)),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 7.5,
                        children: List.generate(hashtags.length, (index) {
                          return ElevatedButton.icon(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  hashtags.removeAt(index);
                                });
                              },
                              label: Text(hashtags[index]));
                        }),
                      ),
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
                  post: PostFormat().toPost({
                'content': _content.text,
                'tags': hashtags.toList(),
                'title': _title.text,
              })));
          Navigator.of(context).pop();
        },
        child: const Icon(Icons.chevron_right_sharp),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
