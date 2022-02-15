
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/functions/firestoreHelper.dart';
import 'package:my_first_flutter_app/model/User.dart';
import 'package:file_picker/file_picker.dart';
import 'package:date_time_format/date_time_format.dart';

class myDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return myDrawerState();
  }
}

class myDrawerState extends State<myDrawer> {
  String? identifiant;
  Users? utilisateur;
  DateTime time = DateTime.now();
  // DateFormat dateFormat = DateFormat.yMd("fr_FR");
  String imageFilePath = "";
  Uint8List? bytesImage;
  String imageFileName = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirestoreHelper().getIdentifiant().then((value) {
      setState(() {
        identifiant = value;
      });
      FirestoreHelper().getUser(identifiant!).then((value) {
        setState(() {
          utilisateur = value;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      padding: EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width / 1.5,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: (utilisateur!.image == null)
                      ? NetworkImage(
                          "https://firebasestorage.googleapis.com/v0/b/myfirstflutterapp-22298.appspot.com/o/empty_img.jpg?alt=media&token=4e8674ed-10b5-48d0-b7c6-b8d05a19391a")
                      : NetworkImage(utilisateur!.image!)),
            ),
          ),
            onTap: (){
              (utilisateur!.image==null)?Container():printImage();
            },
            onLongPress: () async{
              FilePickerResult? resultat = await FilePicker.platform.pickFiles(
                withData: true,
                type:FileType.image
              );
              if(resultat!=null){
                setState(() {
                  imageFileName = resultat.files.first.name;
                  bytesImage = resultat.files.first.bytes;
                  print(imageFileName);
                });
                await afficherImage();
              }
            },
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text(
                "${utilisateur?.pseudo}",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              IconButton(
                  onPressed: () {
                    PseudoEdit();
                  },
                  icon: Icon(Icons.edit))
            ],
          ),
          SizedBox(height: 10),
          Text("${utilisateur!.prenom} ${utilisateur!.nom}"),
          Row(
            children: [Icon(Icons.mail), Text("${utilisateur!.mail}")],
          ),
          SizedBox(height: 10),
          (utilisateur!.dateNaissance == null)
              ? Text(time.toString())
              : Text(utilisateur!.dateNaissance!.toString()),
          IconButton(
              onPressed: () {
                FirestoreHelper().logUser();
              },
              icon: Icon(Icons.exit_to_app_rounded)),
          IconButton(
              onPressed: () {
                BoxDelete();
              },
              icon: Icon(
                Icons.logout,
                color: Colors.red,
              )),
        ],
      ),
    );
  }

  afficherImage(){
    return showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("Souhaitez-vous enregistrer cette image ?"),
          content: Image.memory(bytesImage!, width: 400, height: 400,),
          actions: [
            ElevatedButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text("Annuler")
            ),
            ElevatedButton(
              onPressed: (){
                FirestoreHelper().stockageImage(imageFileName, bytesImage!).then((value){
                  setState(() {
                    imageFilePath = value;
                  });
                  Map<String, dynamic> map = {
                   "IMAGE": imageFilePath,
                  };
                  FirestoreHelper().updateUser(utilisateur!.id!, map);
                });
              },
              child: Text("Enregistrer")
            )
          ],
        );
      }
    );
  }

  printImage(){
    return showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          content: Image.network(utilisateur!.image!, width: 400, height: 400,),
          actions: [
            ElevatedButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text("OK")
            )
          ],
        );
      }
    );
  }

  PseudoEdit() {
    String update = "";
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Nouveau pseudo : "),
            content: TextField(
              onChanged: (newValue){
                setState(() {
                  update = newValue;
                });
              },
            ),
            actions: [
              ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text("Annuler")
              ),
              ElevatedButton(
                  onPressed: (){
                    Map<String,dynamic> map = {
                      "PSEUDO": update
                    };
                  },
                  child: Text("Sauvegarder")
              ),
            ],
          );
        });
  }

  BoxDelete() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          if (Platform.isIOS) {
            return CupertinoAlertDialog(
              title: Text("Supprimer le compte ?"),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Non"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Oui"),
                ),
              ],
            );
          } else {
            return AlertDialog(
              title: Text("Supprimer le compte ?"),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Non"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Oui"),
                ),
              ],
            );
          }
        });
  }
}
