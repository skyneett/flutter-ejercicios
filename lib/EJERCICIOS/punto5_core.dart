// ignore_for_file: avoid_print
/// Analiza una cadena de texto y retorna un mapa con varias estadísticas.
Map<String, dynamic> analizarTexto(String texto) {
  // 1. Inicializar variables
  int numCaracteres = texto.length;
  int numVocales = 0;
  int numConsonantes = 0;
  String palabraMasLarga = "";

  // 2. Limpiar y separar el texto en palabras
  // Eliminar caracteres especiales y puntuación (excepto espacios) y convertir a minúsculas
  String textoLimpio = texto.toLowerCase().replaceAll(
    RegExp(r'[^\w\s]', unicode: true),
    '',
  );

  // Dividir por uno o más espacios en blanco, excluyendo las cadenas vacías resultantes
  final palabras = textoLimpio
      .split(RegExp(r'\s+'))
      .where((p) => p.isNotEmpty)
      .toList();

  int numPalabras = palabras.length;

  // 3. Contar vocales y consonantes, y encontrar la palabra más larga
  final regexVocales = RegExp(r'[aeiouáéíóúü]');
  final regexConsonantes = RegExp(r'[bcdfghjklmnñpqrstvwxyz]');

  for (var palabra in palabras) {
    // 3a. Encontrar la palabra más larga
    if (palabra.length > palabraMasLarga.length) {
      palabraMasLarga = palabra;
    }

    // 3b. Contar vocales y consonantes
    for (int i = 0; i < palabra.length; i++) {
      String char = palabra[i];
      if (regexVocales.hasMatch(char)) {
        numVocales++;
      } else if (regexConsonantes.hasMatch(char)) {
        numConsonantes++;
      }
    }
  }

  // 4. Construir y retornar el mapa de estadísticas
  return {
    'numero_palabras': numPalabras,
    'numero_caracteres_totales': numCaracteres,
    'numero_vocales': numVocales,
    'numero_consonantes': numConsonantes,
    'palabra_mas_larga': palabraMasLarga,
  };
}

// Ejemplo de uso (demo). Se puede ejecutar directamente:
// dart run .\lib\EJERCICIOS\punto5_core.dart
void main(List<String> args) {
  String miTexto =
      "¡Hola Mundo! Este es un ejemplo de análisis de texto en Dart, utilizando la programación.";

  final estadisticas = analizarTexto(miTexto);

  print("Texto Analizado: \"$miTexto\"");
  print("\n--- Estadísticas ---");
  print("Número de Palabras: ${estadisticas['numero_palabras']}");
  print(
    "Caracteres (incl. espacios y puntuación): ${estadisticas['numero_caracteres_totales']}",
  );
  print(
    "Vocales (a, e, i, o, u, acentuadas, etc.): ${estadisticas['numero_vocales']}",
  );
  print("Consonantes: ${estadisticas['numero_consonantes']}");
  print(
    "Palabra Más Larga: '${estadisticas['palabra_mas_larga']}' (Longitud: ${estadisticas['palabra_mas_larga'].length})",
  );
}
