import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final Map<String, dynamic> details;
  const DetailsPage({super.key, required this.details});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            children: [
              ListTile(
                title: Text('Posted By - ' + widget.details['madeBy']),
              ),
              Card(
                elevation: 40,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: const Color.fromARGB(255, 13, 47, 47),
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
                                      child:
                                          Text(widget.details['tags'][index]));
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
              const SizedBox(
                height: 20,
              ),
              const Text('Comments'),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
