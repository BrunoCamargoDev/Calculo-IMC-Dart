import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp ({super.key});
  
   @override
  Widget build(BuildContext context) {
    return const MaterialApp(
    home: ImcCalculator(),
    );
  }
}

class ImcCalculator extends StatefulWidget {
  const ImcCalculator ({super.key});
  
  @override
  State<ImcCalculator> createState() => _ImcCalculatorState();
}

class _ImcCalculatorState extends State<ImcCalculator> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  String _resultText = 'Informe seus dados para calcular o IMC';
  Color _resultTextColor = Colors.black;
  
  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }
  
  void _calculateImc() {
    double? weight = double.tryParse(_weightController.text);
    double? height = double.tryParse(_heightController.text);
    
    if (weight == null || height == null || weight <= 0 || height <= 0) {
      setState(() {
        _resultText = 'Por favor, insira valores válidos para peso e altura.';
        _resultTextColor = Colors.red;
      });
      return;
  }
    
    // A altura é em centímetros, então a gente converte para metros
    height = height / 100;
    
    double imc = weight / (height * height);
    
    setState((){
      _resultText = 'Seu IMC é: ${imc.toStringAsFixed(2)}\n';
      _resultTextColor = Colors.black;
      if (imc < 18.5){
        _resultText += 'Abaixo do peso';
        _resultTextColor = Colors.orange;
      } else if (imc >= 18.5 && imc <= 24.9){
        _resultText += 'Peso normal';
        _resultTextColor = Colors.green;
      } else if (imc >= 25 && imc <= 29.9){
        _resultText += 'Sobrepeso';
        _resultTextColor = Colors.orange;
      } else if (imc >= 30 && imc <= 34.9){
        _resultText += 'Obesidade grau I';
        _resultTextColor = Colors.red;
      } else if (imc >= 35 && imc <= 39.9){
        _resultText += 'Obesidade grau II';
        _resultTextColor = Colors.red;
      } else {
        _resultText += 'Obesidade grau III (mórbita)';
        _resultTextColor = Colors.red;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
    ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Icon(
              Icons.person,
              size: 120.0,
              color: Colors.blueAccent,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Peso (kg)',
                border: OutlineInputBorder(),
                suffixText: 'kg',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Altura (cm)',
                border: OutlineInputBorder(),
                suffixText: 'cm',
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50.0,
              child: ElevatedButton(
                onPressed: _calculateImc,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,  
                ),
                child: const Text(
                  'Calcular',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _resultText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: _resultTextColor,
              ),
            ),
        ],
      ),
    ),
   );
  }
}