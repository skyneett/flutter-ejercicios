import 'package:flutter/material.dart';
import '../EJERCICIOS/punto2_core.dart';

class ValidadorPasswordScreen extends StatefulWidget {
  const ValidadorPasswordScreen({super.key});

  @override
  State<ValidadorPasswordScreen> createState() =>
      _ValidadorPasswordScreenState();
}

class _ValidadorPasswordScreenState extends State<ValidadorPasswordScreen> {
  final _passwordController = TextEditingController();
  bool _isValid = false;
  bool _showValidation = false;
  bool _obscureText = true;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _validar() {
    final password = _passwordController.text;
    setState(() {
      _isValid = validarContrasena(password);
      _showValidation = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Validador de Contraseñas'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.lock, size: 80, color: Colors.deepPurple),
            const SizedBox(height: 32),
            const Text(
              'Requisitos de la contraseña:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildRequirement('Mínimo 8 caracteres'),
            _buildRequirement('Al menos una mayúscula (A-Z)'),
            _buildRequirement('Al menos una minúscula (a-z)'),
            _buildRequirement('Al menos un número (0-9)'),
            _buildRequirement(
              'Al menos un carácter especial (!@#\$%^&*()-_+=)',
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _passwordController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.password),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
              onChanged: (_) {
                if (_showValidation) {
                  _validar();
                }
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _validar,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Validar Contraseña',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 32),
            if (_showValidation)
              Card(
                elevation: 4,
                color: _isValid ? Colors.green[50] : Colors.red[50],
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Icon(
                        _isValid ? Icons.check_circle : Icons.cancel,
                        size: 64,
                        color: _isValid ? Colors.green : Colors.red,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _isValid
                            ? '✓ Contraseña válida'
                            : '✗ Contraseña inválida',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: _isValid ? Colors.green : Colors.red,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _isValid
                            ? 'La contraseña cumple con todos los requisitos de seguridad.'
                            : 'La contraseña no cumple con todos los requisitos.',
                        style: const TextStyle(fontSize: 16),
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

  Widget _buildRequirement(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline, size: 20, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}
