import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            color: Colors.white
          )
        ),
        useMaterial3: true,
      ),
      home:calculator(),
    );
  }
}

class calculator extends StatefulWidget{
  @override 
  _calculatorState createState() => _calculatorState();
}

class _calculatorState extends State<calculator>{
  String output = "0";

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        output = "0"; // Clear output
      } else if (buttonText == "=") {
        try {
          output = evaluatedExpression(output); // Evaluasi ekspresi
        } catch (e) {
          output = "Error"; // Jika ada kesalahan
        }
      } else {
        // Untuk tombol selain C dan =
        if (output == "0") {
          output = buttonText; // Mengganti angka jika 0
        } else {
          output += buttonText; // Menambah angka atau simbol ke output
        }
      }
    });
  }
    String evaluatedExpression(String expression){
      final parsedExpression = Expression.parse(expression); //digunakan untuk mengubah string menjadi int
      final evaluator = ExpressionEvaluator(); //untuk menghitung bilangan yang ditambahkan, digunakan untuk membaca (+,-,/,x)
      final result = evaluator.eval(parsedExpression, {}); //untuk menyimpan hasil perhitungan

      return result.toString();
    }

    Widget buildButton (String buttonText, Color color, {double widthFactor = 1.0}){
      return Expanded(
        flex: widthFactor.toInt(),
        child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 22),
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40)),
              elevation: 0),
              onPressed: () => buttonPressed(buttonText),
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
              )
            )
          ));
    }

    @override
    Widget build(BuildContext context){
      return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(right: 24, left: 24),
                alignment: Alignment.bottomRight,
                child: Text (output,
                style: TextStyle(
                  fontSize: 80,
                  color: Colors.white
                ),
                )
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    buildButton("AC", Colors.grey),
                    buildButton("+/-", Colors.grey),
                    buildButton("%", Colors.grey),
                    buildButton("÷", Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    buildButton("7", Colors.grey),
                    buildButton("8", Colors.grey),
                    buildButton("9", Colors.grey),
                    buildButton("*", Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    buildButton("4", Colors.grey),
                    buildButton("5", Colors.grey),
                    buildButton("6", Colors.grey),
                    buildButton("-", Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    buildButton("1", Colors.grey),
                    buildButton("2", Colors.grey),
                    buildButton("3", Colors.grey),
                    buildButton("+", Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    buildButton("0", Colors.grey, widthFactor: 2),
                    buildButton(".", Colors.grey),
                    buildButton("=", Colors.orange),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }
  }


  