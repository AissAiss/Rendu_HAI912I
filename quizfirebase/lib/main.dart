import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Doc importante
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:firebase_database/firebase_database.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(home: QuizzPage(title: '',),),);
}
class QuizzPage extends StatefulWidget {
  const QuizzPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() => SomeQuizzPageState();
}

class SomeQuizzPageState extends State<QuizzPage> {

  Question question = Question(questionText: "Lucas est étudiant ?", isCorrect: true);
  Color correct = Colors.blue;
  Color wrong = Colors.blue;
  bool hasAnwsered = false;

  // Firebase
  //final Stream<QuerySnapshot> _questionStream = FirebaseFirestore.instance.collection('Questions').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x92DADBE0),
      appBar: _getAppBar(),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 50),
            _getImage(),
            const SizedBox(height: 50),
            _getQuestion(),
            const SizedBox(height: 50),
            _getButtons(),

          ],
        ),
      ),
    );
  }

  Container _getButtons() {
    return Container(
        alignment: Alignment.center,
        child: Row(
          children: <Widget>[
            Expanded(
                child: TextButton(
                  style: _getBtnStyle(color: correct),
                  onPressed: () {
                    if (question.isCorrect) {
                      setState(() { correct = Colors.green; wrong = Colors.red; hasAnwsered = true;});
                    }else {
                      setState(() { wrong = Colors.green; correct = Colors.red; hasAnwsered = true;});
                    }
                  },
                  child: const Text("Vrai",
                      textAlign: TextAlign.left,style: TextStyle(color: Colors.black87,fontSize: 20,fontWeight: FontWeight.bold)),
                )
            ),
            Expanded(
                child: TextButton(
                  style: _getBtnStyle(color: wrong),
                  onPressed: () {
                    if (question.isCorrect) {
                      setState(() { correct = Colors.green; wrong = Colors.red; hasAnwsered = true;});
                    }else {
                      setState(() { wrong = Colors.green; correct = Colors.red; hasAnwsered = true;});
                    }
                  },
                  child: const Text("Faux",
                      textAlign: TextAlign.left,style: TextStyle(color: Colors.black87,fontSize: 20,fontWeight: FontWeight.bold)),
                )
            ),
            Expanded(
                child: TextButton(
                  style: _getBtnStyle(),
                  onPressed: () {
                    setState(() async {
                      if (hasAnwsered) {
                        question = await NewQuestion();
                        correct = Colors.blue;
                        wrong = Colors.blue;
                        hasAnwsered = false;
                      }
                    });
                  },
                  child: const Text("->",
                      textAlign: TextAlign.left,style: TextStyle(color: Colors.black87,fontSize: 20,fontWeight: FontWeight.bold)),
                )
            ),
          ],
        )

    );
  }

  ButtonStyle _getBtnStyle({Color color=Colors.blue}) {
    return ElevatedButton.styleFrom(
      primary: color,
      onPrimary: Colors.white,
      shadowColor: Colors.blueAccent,
      elevation: 3,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0)),
      minimumSize: const Size(150, 75), //////// HERE
    );
  }

  Container _getQuestion() {
    return Container(
      alignment: Alignment.center,
      width: 300.00,
      child: Text(question.questionText,
          textAlign: TextAlign.left,
          style: const TextStyle(color: Colors.black87,fontSize: 20,fontWeight: FontWeight.bold)),
    );
  }

  Container _getImage() {
    return Container(
      alignment: Alignment.center,
      child: Container(
        width: 200.00,
        height: 100.00,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('/home/aissaiss/StudioProjects/quizfirebase/pics/quiz.png'),
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }

  AppBar _getAppBar() {
    return AppBar(
      title: const Text("Quizz"),
      centerTitle: true,
    );
  }

  Future<Question> NewQuestion() async {

    FirebaseDatabase database = FirebaseDatabase.instance;

    DatabaseReference isCorrect = database.ref("1/isCorrect");
    DatabaseReference questionText = database.ref("1/questionText");

    DatabaseEvent eventCorrect = await isCorrect.once();
    DatabaseEvent eventQuestion = await questionText.once();

    debugPrint('dataq:' + eventQuestion.snapshot.value.toString());

    String q = eventQuestion.snapshot.value.toString();
    bool c = eventCorrect.snapshot.value.toString() == "true";

    return Question(questionText: q, isCorrect: c);
  }

}

class Question {
  String questionText;
  bool isCorrect;

  Question({required this.questionText, required this.isCorrect});
}