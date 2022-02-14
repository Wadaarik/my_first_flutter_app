import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/functions/firestoreHelper.dart';

class signin extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return signinState();
  }

}
class signinState extends State<signin>{
  String? mail;
  String? prenom;
  String? nom;
  String? password;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Enregistrement"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),

        child: bodyPage(),
      ),
    );
  }

  Widget bodyPage(){
    return Column(
      children: [
        TextField(
          onChanged: (String text){
            setState(() {
              nom = text;
            });
          },
          decoration: InputDecoration(
            hintText: "Entrez votre nom",
              icon: Icon(Icons.person, size: 25, color: Colors.blue),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15)
              )
          ),
        ),
        SizedBox(height: 15,),
        TextField(
          onChanged: (String text){
            setState(() {
              prenom = text;
            });
          },
          decoration: InputDecoration(
              hintText: "Entrez votre prénom",
              icon: Icon(Icons.person, size: 25, color: Colors.blue),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15)
              )
          ),
        ),
        SizedBox(height: 15,),
        TextField(
          onChanged: (String text){
            setState(() {
              mail = text;
            });
          },
          decoration: InputDecoration(
              hintText: "Entrez votre mail",
              icon: Icon(Icons.mail, size: 25, color: Colors.blue),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15)
              )
          ),
        ),
        SizedBox(height: 15,),
        TextField(
          obscureText: true,
          onChanged: (String text){
            setState(() {
              password = text;
            });
          },
          decoration: InputDecoration(
              hintText: "•••••••",
              icon: Icon(Icons.lock, size: 25, color: Colors.blue),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15)
              )
          ),
        ),
        SizedBox(height: 15,),
        ElevatedButton(
            onPressed: (){
              FirestoreHelper().CreationUser(mail: mail, password: password, prenom: prenom, nom: nom);
            },

            child: Text("Je m'inscris")
        ),
      ],
    );
  }

}