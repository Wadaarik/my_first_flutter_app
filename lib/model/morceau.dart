
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Morceau {
  String id="";
  String title="";
  String author = "";
  String song_path = "";
  String? title_album;
  String? image_musique;
  String? type_musique;

  Morceau(DocumentSnapshot snapshot){
    id = snapshot.id;
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    title = map["TITLE"];
    author = map["AUTHOR"];
    song_path = map["SONG_PATH"];
    title_album = map["TITLE_ALBUM"];
    image_musique = map["IMAGE_MUSIQUE"];
    type_musique = map["TYPE_MUSIQUE"];
  }
}