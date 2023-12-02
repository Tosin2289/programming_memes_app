import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future getmeme() async {
    try {
      var url = "https://programming-memes-images.p.rapidapi.com/v1/memes";
      Map<String, String> headers = {
        'X-RapidAPI-Key': 'b69cb11239mshab2a2abc94c6a70p16a0dbjsna6609ede3bdb',
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
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Programming memes",
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
        child: Expanded(
          child: SizedBox(
            child: FutureBuilder(
              future: getmeme(),
              builder: ((context, snapshot) {
                if (snapshot.data == null) {
                  return SizedBox(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            'assets/laughing.json',
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          const Text(
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
                } else {
                  return RefreshIndicator(
                    onRefresh: () async {
                      setState(() {
                        getmeme();
                      });
                    },
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 10),
                            child: CardSwiper(
                                numberOfCardsDisplayed: 3,
                                padding: const EdgeInsets.all(24.0),
                                backCardOffset: const Offset(40, 40),
                                cardsCount: snapshot.data.length,
                                cardBuilder: ((
                                  context,
                                  index,
                                  horizontalThresholdPercentage,
                                  verticalThresholdPercentage,
                                ) {
                                  return Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              snapshot.data[index].image)),
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Image.network(
                                      snapshot.data[index].image,
                                      fit: BoxFit.contain,
                                    ),
                                  );
                                })),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              getmeme();
            });
          },
          child: Icon(Icons.refresh)),
    );
  }
}

class user {
  final String image;
  user(this.image);
}
