import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future getmeme() async {
    var url = "https://programming-memes-images.p.rapidapi.com/v1/memes";
    Map<String, String> headers = {
      'X-RapidAPI-Key': 'Your rapid api key',
      'X-RapidAPI-Host': 'programming-memes-images.p.rapidapi.com'
    };
    var response = await http.get(Uri.parse(url), headers: headers);
    var jsonData = jsonDecode(response.body);
    List<user> Users = [];
    for (var u in jsonData) {
      user users = user(
        u['image'],
      );
      Users.add(users);
    }
    return Users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          title: Text("Programming memes"),
        ),
        backgroundColor: Colors.blueAccent[400],
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
          child: Container(
            child: FutureBuilder(
              future: getmeme(),
              builder: ((context, snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            'assets/laughing.json',
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            'Created by Phenomes',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  );
                } else
                  return RefreshIndicator(
                    triggerMode: RefreshIndicatorTriggerMode.onEdge,
                    strokeWidth: RefreshProgressIndicator.defaultStrokeWidth,
                    onRefresh: getmeme,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 10),
                      child: PageView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          itemBuilder: ((context, index) {
                            return Container(
                              height: 400,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        snapshot.data[index].image)),
                                color: Colors.white10,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            );
                          })),
                    ),
                  );
              }),
            ),
          ),
        ));
  }
}

class user {
  final String image;
  user(this.image);
}
