import 'package:cloud_firestore/cloud_firestore.dart';

class Users{
  String? id;
  String? pseudo;
  String? nom;
  String? prenom;
  String? image;
  String? mail;
  DateTime? dateNaissance;



  Users(DocumentSnapshot snapshot){
    id = snapshot.id;
    //PAR DEFAUT LA DATA EST OPTIONNEL, PERMET DE FORCER L'INTEGRATION
    Map<String,dynamic> map = snapshot.data() as Map<String,dynamic>;
    pseudo = map["PSEUDO"];
    nom = map["NOM"];
    prenom = map["PRENOM"];
    image = map["IMAGE"];
    mail = map["MAIL"];
    dateNaissance = map["DATENAISSANCE"];
  }
}