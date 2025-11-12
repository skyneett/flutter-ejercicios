import 'package:flutter/material.dart';
import '../EJERCICIOS/punto1_core.dart';

class IMCScreen extends StatefulWidget {
  const IMCScreen({super.key});

  @override
  State<IMCScreen> createState() => _IMCScreenState();
}

class _IMCScreenState extends State<IMCScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pesoController = TextEditingController();
  final _alturaController = TextEditingController();
  String _resultado = '';
  Color _resultColor = Colors.black;

  @override
  void dispose() {
    _pesoController.dispose();
    _alturaController.dispose();
    super.dispose();
  }

  void _calcularIMC() {
    if (_formKey.currentState!.validate()) {
      final peso = int.parse(_pesoController.text);
      final altura = double.parse(_alturaController.text);

      try {
        final clasificacion = calcularYClasificarImc(peso, altura);
        final imc = peso / (altura * altura);

        setState(() {
          _resultado = 'IMC: ${imc.toStringAsFixed(2)}\n$clasificacion';
          _resultColor = _getColorForClassification(clasificacion);
        });
      } catch (e) {
        setState(() {
          _resultado = 'Error: ${e.toString()}';
          _resultColor = Colors.red;
        });
      }
    }
  }

  Color _getColorForClassification(String clasificacion) {
    if (clasificacion.contains('normal')) return Colors.green;
    if (clasificacion.contains('Bajo')) return Colors.orange;
    if (clasificacion.contains('Sobrepeso')) return Colors.amber;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.monitor_weight, size: 80, color: Colors.blue),
              const SizedBox(height: 32),
              TextFormField(
                controller: _pesoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Peso (kg)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.fitness_center),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el peso';
                  }
                  final peso = int.tryParse(value);
                  if (peso == null || peso <= 0) {
                    return 'Ingrese un peso válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _alturaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Altura (metros)',
                  hintText: 'Ej: 1.75',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.height),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la altura';
                  }
                  final altura = double.tryParse(value);
                  if (altura == null || altura <= 0) {
                    return 'Ingrese una altura válida';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _calcularIMC,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Calcular IMC',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 32),
              if (_resultado.isNotEmpty)
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        const Text(
                          'Resultado',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _resultado,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: _resultColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
