import 'package:flutter/material.dart';
import 'package:social_media/services/post/post_format.dart';
import 'package:social_media/services/post/post_services.dart';

import '../constants/time_diff.dart';

class DetailsPage extends StatefulWidget {
  final Map<String, dynamic> details;
  const DetailsPage({super.key, required this.details});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final TextEditingController _textF = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              children: [
                const SizedBox(height: 20),
                ListTile(
                  title: Text('Posted By - ' + widget.details['madeBy']),
                  subtitle: Row(
                    children: [
                      Text(DateTimeDifference()
                          .getDiff(widget.details['madeAt'], DateTime.now())),
                      const SizedBox(width: 40),
                      (widget.details['open'] == true)
                          ? const CircleAvatar(
                              backgroundColor: Colors.green,
                              radius: 5,
                            )
                          : const CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 5,
                            ),
                      const SizedBox(width: 10),
                      (widget.details['open'] == true)
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
                        Text(widget.details['content'].toString()),
                        const SizedBox(height: 30),
                        (widget.details['tags'].length > 0)
                            ? Align(
                                alignment: Alignment.topLeft,
                                child: Wrap(
                                  spacing: 10,
                                  runSpacing: 7.5,
                                  children: List.generate(
                                      widget.details['tags'].length, (index) {
                                    return ElevatedButton(
                                        onPressed: () {},
                                        child: Text(
                                            widget.details['tags'][index]));
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
                    itemCount: widget.details['comments'].length,
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
                          title: Text(widget.details['comments'][index]
                                  ['madeBy']
                              .toString()),
                          subtitle: Text(widget.details['comments'][index]
                                  ['content']
                              .toString()),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showModalBottomSheet(
              context: context,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      TextField(
                        controller: _textF,
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                          onPressed: () {
                            Map<String, dynamic> comment = {
                              'content': _textF.text,
                            };
                            PostServices().postComments(widget.details['id'],
                                PostFormat().toComment(comment));
                            setState(() {
                              Navigator.of(context).pop();
                            });
                          },
                          child: const Text('POST')),
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
