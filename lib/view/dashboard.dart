import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/controller/all_morceaux.dart';
import 'package:my_first_flutter_app/view/MyDrawer.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';

import '../controller/character.dart';

class dashboard extends StatefulWidget{

  String? mail;
  String? password;
  dashboard(String? this.mail, String? this.password);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return dashboardState();
  }

}
class dashboardState extends State<dashboard>{
  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: myDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Mon Dashboard"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: bodyPage(currentIndex),
      ),
      bottomNavigationBar: DotNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.cyan,
        onTap: (int newValue){
          setState(() {
            currentIndex = newValue;
          });
        },
        currentIndex: currentIndex,
        items: [
          DotNavigationBarItem(
            icon: Icon(Icons.music_note_sharp),
          ),
          DotNavigationBarItem(
            icon: Icon(Icons.person),
          ),
          DotNavigationBarItem(
            icon: Icon(Icons.map_sharp),
          ),
        ],
      ),
    );
  }

  Widget bodyPage(int value){
    switch(value){
      case 0 : return allMorceaux();
      case 1 : return character();
      case 2 : return Text("Afficher une carte");
      default: return Text("Aucune info");
    }
  }

}