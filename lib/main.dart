import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MySplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MySplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: MyHomePage(),
      backgroundColor: Colors.white,
      title: Text("Parsing Data by Hega"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var link = "https://jsonplaceholder.typicode.com/posts";
  List<Map<String, dynamic>> data = [];

  Future getData() async {
    Response res = await Dio().get(link);
    for (var i = 0; i < res.data.length; i++) {
      data.add(res.data[i]);
    }
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Post"),
        ),
        body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, i) {
            Map<String, dynamic> itemData = data[i];
            return Padding(
              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ContentPost(dataSelected: itemData)));
                },
                color: Colors.blueGrey[100],
                minWidth: double.maxFinite,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      itemData['title'],
                      style: TextStyle(),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}

class ContentPost extends StatefulWidget {
  final Map<String, dynamic> dataSelected;

  const ContentPost({Key key, this.dataSelected}) : super(key: key);
  @override
  _ContentPostState createState() => _ContentPostState();
}

class _ContentPostState extends State<ContentPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post " + widget.dataSelected['id'].toString()),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(flex: 2, child: Text("User Id")),
                Expanded(flex: 1, child: Text(":")),
                Expanded(
                    flex: 7,
                    child: Text(widget.dataSelected['userId'].toString()))
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: <Widget>[
                Expanded(flex: 2, child: Text("Id")),
                Expanded(flex: 1, child: Text(":")),
                Expanded(
                    flex: 7, child: Text(widget.dataSelected['id'].toString()))
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(flex: 2, child: Text("Title")),
                Expanded(flex: 1, child: Text(":")),
                Expanded(flex: 7, child: Text(widget.dataSelected['title']))
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(flex: 2, child: Text("Body")),
                Expanded(flex: 1, child: Text(":")),
                Expanded(flex: 7, child: Text(widget.dataSelected['body']))
              ],
            ),
            SizedBox(height: 20),
            Text("~~~~~~~~~ atau ~~~~~~~~~"),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.dataSelected['title'],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.dataSelected['body'],
                style: TextStyle(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
