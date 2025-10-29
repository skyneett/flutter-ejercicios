String calcularYClasificarImc(int pesoKg, double alturaMetros) {
  if (pesoKg <= 0) {
    throw ArgumentError('El peso debe ser un valor positivo.');
  }
  if (alturaMetros <= 0) {
    throw ArgumentError('La altura debe ser un valor positivo.');
  }

  double imc = pesoKg / (alturaMetros * alturaMetros);

  if (imc < 18.5) {
    return 'Bajo peso';
  } else if (imc < 24.9) {
    return 'Peso normal';
  } else if (imc < 29.9) {
    return 'Sobrepeso';
  } else if (imc < 34.9) {
    return 'Obesidad Grado I';
  } else if (imc < 39.9) {
    return 'Obesidad Grado II';
  } else {
    return 'Obesidad Grado III (Mórbida)';
  }
}

/// Ejecuta ejemplos de uso de la lógica del Punto 1 (IMC).
///
/// Esta función contiene los ejemplos y `print` para mostrar resultados en
/// consola. Mantener la demo aquí centraliza la lógica del punto 1.
void demoPunto1() {
  try {
    int peso1 = 70;
    double altura1 = 1.75;
    String clasificacion1 = calcularYClasificarImc(peso1, altura1);
    print('Peso: ${peso1}kg, Altura: ${altura1}m -> IMC: $clasificacion1');

    int peso2 = 50;
    double altura2 = 1.70;
    String clasificacion2 = calcularYClasificarImc(peso2, altura2);
    print('Peso: ${peso2}kg, Altura: ${altura2}m -> IMC: $clasificacion2');

    print(
      'Peso: 85kg, Altura: 1.70m -> IMC: ${calcularYClasificarImc(85, 1.70)}',
    );
    print(
      'Peso: 120kg, Altura: 1.80m -> IMC: ${calcularYClasificarImc(120, 1.80)}',
    );
  } on ArgumentError catch (e) {
    print('Error: ${e.message}');
  }
}

// ignore_for_file: avoid_print
/// Permite ejecutar este archivo directamente: `dart run .\lib\EJERCICIOS\punto1_core.dart`
void main(List<String> args) {
  demoPunto1();
}
