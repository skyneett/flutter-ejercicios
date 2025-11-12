import 'package:flutter/material.dart';
import '../EJERCICIOS/Punto4_core.dart';

class TemperaturaScreen extends StatefulWidget {
  const TemperaturaScreen({super.key});

  @override
  State<TemperaturaScreen> createState() => _TemperaturaScreenState();
}

class _TemperaturaScreenState extends State<TemperaturaScreen> {
  final _temperatureController = TextEditingController();
  TemperatureUnit _fromUnit = TemperatureUnit.celsius;
  TemperatureUnit _toUnit = TemperatureUnit.fahrenheit;
  String _resultado = '';

  @override
  void dispose() {
    _temperatureController.dispose();
    super.dispose();
  }

  void _convertir() {
    final temp = double.tryParse(_temperatureController.text);
    if (temp == null) {
      setState(() {
        _resultado = 'Por favor ingrese un valor válido';
      });
      return;
    }

    final converter = TemperatureConverter(temp, _fromUnit);
    final result = converter.convertTo(_toUnit);

    setState(() {
      _resultado =
          '${temp.toStringAsFixed(2)}${_getUnitSymbol(_fromUnit)} = '
          '${result.toStringAsFixed(2)}${_getUnitSymbol(_toUnit)}';
    });
  }

  String _getUnitSymbol(TemperatureUnit unit) {
    switch (unit) {
      case TemperatureUnit.celsius:
        return '°C';
      case TemperatureUnit.fahrenheit:
        return '°F';
      case TemperatureUnit.kelvin:
        return 'K';
    }
  }

  String _getUnitName(TemperatureUnit unit) {
    switch (unit) {
      case TemperatureUnit.celsius:
        return 'Celsius';
      case TemperatureUnit.fahrenheit:
        return 'Fahrenheit';
      case TemperatureUnit.kelvin:
        return 'Kelvin';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversor de Temperatura'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.thermostat, size: 80, color: Colors.orange),
            const SizedBox(height: 32),
            TextField(
              controller: _temperatureController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Temperatura',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.edit),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Convertir de:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<TemperatureUnit>(
              value: _fromUnit,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.arrow_upward),
              ),
              items: TemperatureUnit.values.map((unit) {
                return DropdownMenuItem(
                  value: unit,
                  child: Text(_getUnitName(unit)),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _fromUnit = value!;
                });
              },
            ),
            const SizedBox(height: 24),
            const Text(
              'Convertir a:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<TemperatureUnit>(
              value: _toUnit,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.arrow_downward),
              ),
              items: TemperatureUnit.values.map((unit) {
                return DropdownMenuItem(
                  value: unit,
                  child: Text(_getUnitName(unit)),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _toUnit = value!;
                });
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _convertir,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Convertir', style: TextStyle(fontSize: 18)),
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
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
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
    );
  }
}
