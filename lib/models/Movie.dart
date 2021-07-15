import 'package:flutter/material.dart';

class Movie {
  final int id;
  final String title;
  final String synopsis;
  final String image;
  final String genre;

  Movie(
      this.id, this.title, this.synopsis, this.image, this.genre);

  toMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['title'] = title;
    mapping['synopsis'] = synopsis;
    mapping['image'] = image;
    mapping['genre'] = genre;
    return mapping;
  }
}
