// ignore_for_file: avoid_print
/// Genera una secuencia de números de Fibonacci usando un Stream (async*).
///
/// La secuencia comienza con 0, 1, 1, 2, 3, 5, 8...
/// [limit] es la cantidad máxima de números de Fibonacci a generar.
Stream<BigInt> generateFibonacci(int limit) async* {
  if (limit <= 0) return;

  BigInt a = BigInt.zero; // F(0) = 0
  BigInt b = BigInt.one; // F(1) = 1

  // 1. Generar el primer número (si el límite lo permite)
  if (limit >= 1) {
    yield a; // 0
  }

  // 2. Generar el segundo número (si el límite lo permite)
  if (limit >= 2) {
    yield b; // 1
  }

  // 3. Generar el resto de la secuencia
  for (int i = 3; i <= limit; i++) {
    BigInt next = a + b;
    a = b;
    b = next;

    // 'yield' envía el siguiente valor al stream de forma asíncrona.
    yield next;
  }
}

// -------------------------------------------------------------

/// Demo asíncrona que consume el Stream de Fibonacci y muestra resultados.
Future<void> demoPunto7() async {
  final count = 15;

  print("Generando los primeros $count números de Fibonacci:");

  // Consumir el Stream usando un bucle for-await-in
  try {
    // El bucle espera asíncronamente por cada valor del Stream.
    await for (var number in generateFibonacci(count)) {
      print(number);
    }
  } catch (e) {
    print("Ocurrió un error: $e");
  }

  print("\n--- Demostración con un límite diferente (5) ---");
  await for (var number in generateFibonacci(5)) {
    print(number);
  }
}

/// Permite ejecutar este archivo directamente: `dart run .\lib\EJERCICIOS\Punto7_core.dart`
Future<void> main(List<String> args) async {
  await demoPunto7();
}
