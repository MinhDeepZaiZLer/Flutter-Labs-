import 'package:flutter/material.dart';
import 'result_page.dart';
import 'calculator_brain.dart';

void main() => runApp(const BMICalculator());

class BMICalculator extends StatelessWidget {
  const BMICalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0E21),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF0A0E21)),
      ),
      home: const InputPage(),
    );
  }
}

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  int height = 180;
  int weight = 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BMI CALCULATOR')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Thẻ chọn Chiều cao
          Expanded(
            child: Card(
              color: const Color(0xFF1D1E33),
              margin: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('HEIGHT', style: TextStyle(fontSize: 18.0, color: Color(0xFF8D8E98))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(height.toString(), style: const TextStyle(fontSize: 50.0, fontWeight: FontWeight.w900)),
                      const Text('cm'),
                    ],
                  ),
                  Slider(
                    value: height.toDouble(),
                    min: 120.0,
                    max: 220.0,
                    activeColor: Colors.pink,
                    inactiveColor: const Color(0xFF8D8E98),
                    onChanged: (double newValue) {
                      setState(() { height = newValue.round(); });
                    },
                  ),
                ],
              ),
            ),
          ),
          // Thẻ chọn Cân nặng
          Expanded(
            child: Card(
              color: const Color(0xFF1D1E33),
              margin: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('WEIGHT', style: TextStyle(fontSize: 18.0, color: Color(0xFF8D8E98))),
                  Text(weight.toString(), style: const TextStyle(fontSize: 50.0, fontWeight: FontWeight.w900)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton(
                        heroTag: "btn1",
                        backgroundColor: const Color(0xFF4C4F5E),
                        onPressed: () { setState(() { weight--; }); },
                        child: const Icon(Icons.remove),
                      ),
                      const SizedBox(width: 10.0),
                      FloatingActionButton(
                        heroTag: "btn2",
                        backgroundColor: const Color(0xFF4C4F5E),
                        onPressed: () { setState(() { weight++; }); },
                        child: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Nút Tính toán và Chuyển trang
          GestureDetector(
            onTap: () {
              CalculatorBrain calc = CalculatorBrain(height: height, weight: weight);
              
              // Chuyển sang ResultPage và truyền dữ liệu
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultPage(
                    bmiResult: calc.calculateBMI(),
                    resultText: calc.getResult(),
                    interpretation: calc.getInterpretation(),
                  ),
                ),
              );
            },
            child: Container(
              color: Colors.pink,
              margin: const EdgeInsets.only(top: 10.0),
              width: double.infinity,
              height: 80.0,
              child: const Center(child: Text('CALCULATE', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold))),
            ),
          ),
        ],
      ),
    );
  }
}