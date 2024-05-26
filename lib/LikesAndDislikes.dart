import 'package:flutter/material.dart';

class likes_and_dislikes with ChangeNotifier{
  List<String> _likedCats = [];
  List<String> _dislikedCats = [];

  List<String> get likedCats => _likedCats;
  List<String> get dislikedCats => _dislikedCats;

  void add_like(String? url){
    if (!_likedCats.contains(url)) {
      _likedCats.add(url!);
    }
  }

  void add_dislike(String? url){
    if(!_dislikedCats.contains(url)){
      _dislikedCats.add(url!);
    }
  }
}