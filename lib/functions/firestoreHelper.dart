import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../model/User.dart';

class FirestoreHelper{
  final auth = FirebaseAuth.instance;
  final fire_user = FirebaseFirestore.instance.collection("Users");
  final fire_morceau = FirebaseFirestore.instance.collection("Morceaux");
  final firestorage = FirebaseStorage.instance;

  //Method
  Future CreationUser(
      {required String? mail, required String? password, String? prenom, String? pseudo, String? nom}) async{
    UserCredential authresult = await auth.createUserWithEmailAndPassword(email: mail!, password: password!);
    //LES ! PERMETTENT DE SPECIFIER UN NON NULL
    //LES ? PERMETTENT DE DECLARER UN OPTIONNEL
    User? user = authresult.user!;
    String uid = user.uid;
    Map<String, dynamic> map ={
      "PRENOM": prenom,
      "NOM": nom,
      "PSEUDO": pseudo,
      "MAIL": mail,
    };
    addUser(uid, map);
  }

  Future ConnectUser({required String mail, required String password}) async{
    UserCredential authresult = await auth.signInWithEmailAndPassword(email: mail, password: password);
    User? user = authresult.user!;
  }

  addUser(String uid, Map<String, dynamic> map) {
    fire_user.doc(uid).set(map);
  }
  updateUser(String uid, Map<String, dynamic> map) {
    fire_user.doc(uid).update(map);
  }
  deleteUser(String uid, Map<String, dynamic> map) {
    fire_user.doc(uid).delete();
  }
  logUser() {
    auth.signOut();
  }

  Future <String> getIdentifiant() async{
    String? uid = auth.currentUser!.uid;
    return uid;
  }
  Future <Users> getUser(String uid) async{
    DocumentSnapshot snapshot = await fire_user.doc(uid).get();
    return Users(snapshot);
  }

  Future stockageImage(String nomImage,Uint8List data) async{
    TaskSnapshot download = await firestorage.ref("cover/$nomImage").putData(data);
    String urlChemin = await download.ref.getDownloadURL();
    return urlChemin;
  }
}