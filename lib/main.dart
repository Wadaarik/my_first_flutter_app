import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_first_flutter_app/functions/firestoreHelper.dart';
import 'package:my_first_flutter_app/view/dashboard.dart';
import 'package:my_first_flutter_app/view/signin.dart';
import 'package:firebase_core/firebase_core.dart';

//Point d'encrage de l'app
void main() async{
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Ma première app Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String? mail;
  String? password;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  //L'APP COMMENCE ICI
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      //BARRE DE MENU
      appBar: AppBar(
        centerTitle: true,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        //TITLE DU MENU
        title: Text(widget.title),
      ),
      //CORPS
      body: Container(
        padding: EdgeInsets.all(20),
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: bodyPage(),
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget bodyPage(){
    // return Container(
    //   padding: EdgeInsets.all(20),
    //   decoration: BoxDecoration(
    //     color: Colors.red,
    //     borderRadius: BorderRadius.circular(30),
    //   ),
    //   child: Text('Je suis un texte',
    //     style: TextStyle(
    //       color: Colors.white,
    //       fontSize: 45,
    //       fontWeight: FontWeight.bold,
    //     ),
    //   ),
    //   width: 250,
    //   height: 250,
    // );
    // return Image.asset("bob.jpg",
    //   width: 200,
    //   height: 200,
    // );
    // return SingleChildScrollView(
    //     child: Column(
    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //     children: [
    //       Text('Bienvenue'),
    //       Image.asset("bob.jpg"),
    //       Image.asset("bob.jpg"),
    //       Image.asset("bob.jpg"),
    //       Image.asset("bob.jpg"),
    //       Text("Fin du widget")
    //     ]
    // )
    // );
    // return Dismissible(
    //     key: Key("smlsmf"),
    //     direction: DismissDirection.endToStart,
    //     onDismissed: (direction){
    //       print("Hello");
    //     },
    //     background: Container(
    //       color: Colors.red,
    //     ),
    //     child: Container(
    //       child: Text("Je suis un dismissible")
    //     )
    // );
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text("$mail"),
        TextField(
          onChanged: (String text){
            setState(() {
              mail = text;
            });
          },
          decoration: InputDecoration(
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
              icon: Icon(Icons.lock, size: 25, color: Colors.blue),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15)
              )
          ),
        ),
        ElevatedButton(
          onPressed: (){
            FirestoreHelper().ConnectUser(mail: mail!, password: password!).then((value){

              Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context){
                    return dashboard(mail, password);
                  }
              ));
            }).catchError((error) {
              print("Erreur");
            });
          },

          child: Text("Connexion")
        ),
        InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context){
                  return signin();
                }
            ));
            },
            child: Text("Inscription", style: TextStyle(color: Colors.blue),)
        ),
      ],
    );
  }
}
