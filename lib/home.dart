import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class MyStatefulWidget extends StatefulWidget {
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final GlobalKey<_CatImageWidgetState> _catImageWidgetKey =
  GlobalKey<_CatImageWidgetState>();
  List likedCats = [];
  var dio = Dio();

  void _incrementCounter() {
    setState(() {
      //_imageId = getRandomCat();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 255, 220, 239),
                Colors.white,
              ],
            ),
          ),
          height: double.infinity,
          width: double.infinity,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.transparent,
                ),
              ),
              Expanded(
                flex: 8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 70,
                      width: 70,
                      child: Image.asset(
                        'assets/icons/paw.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.82,
                      height: MediaQuery.of(context).size.height * 0.7,
                      // padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(35), // Rounded edges
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF000000)
                                .withOpacity(0.2), // Shadow color
                            spreadRadius: 2, // Spread of the shadow
                            blurRadius: 10, // Blur radius
                            offset: Offset(0, 4), // Shadow offset (x, y)
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(35),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width * 0.82,

                              child: CatImageWidget(key: _catImageWidgetKey),
                              //fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                    onPressed: () {
                                      likeButton();
                                    },
                                    icon: const CircleAvatar(
                                        backgroundColor:
                                        Color.fromARGB(255, 255, 129, 166),
                                        radius: 35,
                                        child: CircleAvatar(
                                          radius: 31,
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                            Icons.favorite,
                                            color: Color.fromARGB(
                                                255, 255, 129, 166),
                                            size: 37,
                                          ),
                                        ))),
                                IconButton(
                                  onPressed: () {
                                    dislikeButton();
                                  },
                                  icon: const CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      radius: 35,
                                      child: CircleAvatar(
                                        radius: 31,
                                        backgroundColor: Colors.white,
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.grey,
                                          size: 40,
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'To like picture of cat click on heart',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ))
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ],
          )),
      bottomNavigationBar: Container(
        height: 50,
        color: const Color.fromARGB(255, 255, 129, 166),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.close, color: Colors.white),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search, color: Colors.white),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }


  Future<String?> getRandomCat() async {
    final String? id = await fetchCatDetails();
    if (id != null) {
      print('Fetched ID: $id');
      return id;
    } else {
      print('Failed to fetch ID');
    }
    return null;
  }

  void likeButton() {
    print("Clicked like button");
    likedCats.add(_catImageWidgetKey.currentState?.imageUrl);
    _catImageWidgetKey.currentState?.fetchAndSetCatImage();

  }

  void dislikeButton() {
    print("Clicked dislike button");
    _catImageWidgetKey.currentState?.fetchAndSetCatImage();
  }
}

Future<String?> fetchCatDetails() async {
  try {
    final response = await Dio().get('https://cataas.com/cat?json=true');
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = response.data;
      final String? id = jsonResponse['_id'];
      return id;
    } else {
      print('Failed to load data');
      return null;
    }
  } catch (e) {
    print('Error: $e');
    return null;
  }
}

class CatImageWidget extends StatefulWidget {
  const CatImageWidget({Key? key}) : super(key: key);

  @override
  _CatImageWidgetState createState() => _CatImageWidgetState();
}

class _CatImageWidgetState extends State<CatImageWidget> {
  String? imageUrl;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchAndSetCatImage();
  }

  Future<void> fetchAndSetCatImage() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final String? id = await fetchCatDetails();
      if (id != null) {
        setState(() {
          imageUrl = 'https://cataas.com/cat/$id';
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to fetch ID';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isLoading
          ? CircularProgressIndicator()
          : errorMessage != null
          ? Text(errorMessage!)
          : imageUrl != null
          ? Image.network(
              imageUrl!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            )
          : Text('No image available'),
    );
  }
}