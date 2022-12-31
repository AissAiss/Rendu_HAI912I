// importation du paquetage pour utiliser Material Design
import 'package:flutter/material.dart';
void main() => runApp(MyApp()); // point d'entrée
// Le widget racine de notre application
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp( // une application utilisant Material Design
        title: 'My First Flutter App',
        theme: ThemeData(/*...*/), // données relatives au thème choisi
        home: const ProfileHomePage(), // le widget de la page d'accueil
        //...
    );
  }
}

// Le widget de notre page d'accueil
class ProfileHomePage extends StatelessWidget {
  const ProfileHomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Profile Card"),
          centerTitle: false,
          //...
      ),
      body: Container(
          alignment: Alignment.center,
          child: Stack(
            alignment: AlignmentDirectional.center,
            clipBehavior: Clip.none,
            children: [
              _getCard(),
              //_getAvatar()
              Positioned(
                  child: _getAvatar(),
              top: -50,),
              //Text("Thomas Juliat", style: TextStyle(color: Colors.white))
            ],
          ),
          //...
      ),
    );
  }
  Container _getCard() {return Container(
    padding: const EdgeInsets.only(top: 100),
    margin: const EdgeInsets.all(10.0),
    width: 300.0,
    height: 230.0,
      decoration: const BoxDecoration(
      color: Colors.pinkAccent,
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(40.0),
          bottomRight: Radius.circular(40.0),
          topLeft: Radius.circular(40.0),
          bottomLeft: Radius.circular(40.0)),
    ),

    child: Column(
      children: const [
        Text("Aissaoui Lucas", style: TextStyle(color: Colors.white)),
        Text("aissaoui@umontpellier.fr", style: TextStyle(color: Colors.white)),
        Text("GitHub : AissAiss", style: TextStyle(color: Colors.white)),
      ]
    )
  );}


  Container _getAvatar() {return Container(
    alignment: Alignment.topCenter,
    width: 150.0,
    height: 150.0,
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.pinkAccent, width: 3, style: BorderStyle.solid, strokeAlign: StrokeAlign.outside),
        image: const DecorationImage(
            image: AssetImage("/home/aissaiss/StudioProjects/profilecard/Pics/lucas.jpeg"),
            fit: BoxFit.cover
        ),
    ));}
}