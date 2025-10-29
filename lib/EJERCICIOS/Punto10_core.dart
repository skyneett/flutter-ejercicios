// ignore_for_file: avoid_print
import 'dart:async';

// Simula la obtención de perfil
Future<Map<String, dynamic>> fetchProfile(String tag) async {
  await Future.delayed(Duration(seconds: 1));
  return {'gamertag': tag, 'rank': 'Major'};
}

// Simula una llamada que falla
Future<void> fetchFailing() async {
  await Future.delayed(Duration(milliseconds: 500));
  throw Exception('Error 404');
}

/// Demo asíncrona del Punto 10: muestra manejo de async/await y errores.
Future<void> demoPunto10() async {
  const tag = 'Chief117';

  // Caso 1: Éxito
  try {
    print('1. Solicitando perfil...');
    final profile = await fetchProfile(tag);
    print('✅ Perfil de ${profile['gamertag']} obtenido.');
  } catch (e) {
    print('❌ Error Inesperado: $e');
  }

  // Caso 2: Error
  try {
    print('\n2. Provocando error...');
    await fetchFailing();
  } catch (e) {
    print('❌ Error Capturado: $e');
  }
}

/// Permite ejecutar este archivo directamente: `dart run .\lib\EJERCICIOS\Punto10_core.dart`
Future<void> main(List<String> args) async {
  await demoPunto10();
}
