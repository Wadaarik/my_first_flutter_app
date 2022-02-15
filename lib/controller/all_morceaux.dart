import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../functions/firestoreHelper.dart';

class allMorceaux extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return allMorceauxState();
  }

}

class allMorceauxState extends State<allMorceaux>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: bodyPage(),
    );
  }

  Widget bodyPage(){
    return StreamBuilder<QuerySnapshot>(
      stream: FirestoreHelper().fire_morceau.snapshots(),
      builder: (context, snapshot){
        if(snapshot.data!.docs.isEmpty){
          return Container(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(),
          );
        }else{
          return Text("J'ai des données");
        }
      },
    );
  }

}
