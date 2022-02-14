import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/view/MyDrawer.dart';

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
        child: bodyPage(),
      ),
    );
  }

  Widget bodyPage(){
    return Column(
      children: [
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage("bob.jpg"),
                  fit: BoxFit.fill
              )
          ),
        ),
        TextField(
          onChanged: (String text){
            setState(() {
            });
          },
          decoration: InputDecoration(
            hintText: "${widget.mail}",
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
      ],
    );
  }

}