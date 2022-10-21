import 'package:flutter/material.dart';
import 'package:social_media/services/apiFunctions.dart';

class test extends StatefulWidget {
  test({Key? key}) : super(key: key);

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiFunctions().getHomePage(),
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? Scaffold(
                appBar: AppBar(),
                body: Column(
                  children: [
                    Text(
                      snapshot.data!["data"]["allPosts"][0]["comments"][0]
                              ["comment"]
                          .toString(),
                    ),
                    Text("data"),
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
