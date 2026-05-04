import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final String bmiResult;
  final String resultText;
  final String interpretation;

  const ResultPage({
    super.key,
    required this.bmiResult,
    required this.resultText,
    required this.interpretation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BMI CALCULATOR')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Expanded(
            child: Center(
              child: Text('Your Result', style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold)),
            ),
          ),
          Expanded(
            flex: 5,
            child: Card(
              color: const Color(0xFF1D1E33),
              margin: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(resultText.toUpperCase(), style: const TextStyle(color: Colors.green, fontSize: 22.0)),
                  Text(bmiResult, style: const TextStyle(fontSize: 100.0, fontWeight: FontWeight.bold)),
                  Text(interpretation, textAlign: TextAlign.center, style: const TextStyle(fontSize: 22.0)),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context); // Nút quay lại màn hình trước
            },
            child: Container(
              color: Colors.pink,
              height: 80.0,
              width: double.infinity,
              child: const Center(child: Text('RE-CALCULATE', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold))),
            ),
          )
        ],
      ),
    );
  }
}