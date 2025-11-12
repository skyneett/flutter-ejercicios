import 'package:flutter/material.dart';
import '../EJERCICIOS/punto5_core.dart';

class AnalizadorTextoScreen extends StatefulWidget {
  const AnalizadorTextoScreen({super.key});

  @override
  State<AnalizadorTextoScreen> createState() => _AnalizadorTextoScreenState();
}

class _AnalizadorTextoScreenState extends State<AnalizadorTextoScreen> {
  final _textoController = TextEditingController();
  Map<String, dynamic>? _estadisticas;

  @override
  void dispose() {
    _textoController.dispose();
    super.dispose();
  }

  void _analizar() {
    final texto = _textoController.text;
    if (texto.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor ingrese un texto')),
      );
      return;
    }

    setState(() {
      _estadisticas = analizarTexto(texto);
    });
  }

  void _limpiar() {
    setState(() {
      _textoController.clear();
      _estadisticas = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analizador de Texto'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.text_fields, size: 80, color: Colors.teal),
            const SizedBox(height: 32),
            TextField(
              controller: _textoController,
              maxLines: 6,
              decoration: const InputDecoration(
                labelText: 'Ingrese el texto a analizar',
                border: OutlineInputBorder(),
                hintText: 'Escriba o pegue su texto aquí...',
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _analizar,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Analizar',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _limpiar,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Limpiar',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            if (_estadisticas != null) ...[
              const Text(
                'Estadísticas del Texto',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              _buildStatCard(
                'Palabras',
                _estadisticas!['numero_palabras'].toString(),
                Icons.notes,
                Colors.blue,
              ),
              _buildStatCard(
                'Caracteres',
                _estadisticas!['numero_caracteres_totales'].toString(),
                Icons.text_format,
                Colors.green,
              ),
              _buildStatCard(
                'Vocales',
                _estadisticas!['numero_vocales'].toString(),
                Icons.circle,
                Colors.orange,
              ),
              _buildStatCard(
                'Consonantes',
                _estadisticas!['numero_consonantes'].toString(),
                Icons.abc,
                Colors.purple,
              ),
              Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 32,
                  ),
                  title: const Text(
                    'Palabra más larga',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    _estadisticas!['palabra_mas_larga'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: Chip(
                    label: Text(
                      '${_estadisticas!['palabra_mas_larga'].length} letras',
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: color, size: 32),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }
}
