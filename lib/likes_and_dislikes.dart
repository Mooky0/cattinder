import 'package:flutter/material.dart';

class LikesAndDislikes with ChangeNotifier{
  final List<String> _likedCats = [];
  final List<String> _dislikedCats = [];

  List<String> get likedCats => _likedCats;
  List<String> get dislikedCats => _dislikedCats;

  void addLike(String? url){
    if (!_likedCats.contains(url)) {
      _likedCats.add(url!);
    }
  }

  void addDislike(String? url){
    if(!_dislikedCats.contains(url)){
      _dislikedCats.add(url!);
    }
  }
}