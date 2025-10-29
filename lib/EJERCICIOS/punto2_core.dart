/// Valida si la contraseña cumple con los criterios de seguridad.
/// Criterios:
/// 1. Mínimo 8 caracteres de longitud.
/// 2. Al menos una letra mayúscula (A-Z).
/// 3. Al menos una letra minúscula (a-z).
/// 4. Al menos un número (0-9).
/// 5. Al menos un carácter especial (ej. !@#\$%^&*()-_+=).
bool validarContrasena(String contrasena) {
  // Expresión regular que utiliza 'lookaheads' para verificar cada criterio
  // sin consumir la cadena, y luego asegura la longitud total.
  final RegExp contrasenaRegExp = RegExp(
    r'^(?=.*[A-Z])' // Debe contener al menos una mayúscula
    r'(?=.*[a-z])' // Debe contener al menos una minúscula
    r'(?=.*\d)' // Debe contener al menos un número
    r'(?=.*[\W_])' // Debe contener al menos un carácter especial (\W coincide con cualquier cosa que no sea una palabra, y \_ para incluir el guión bajo)
    r'.{8,}' // Debe tener una longitud de al menos 8 caracteres
    r'$',
  );

  return contrasenaRegExp.hasMatch(contrasena);
}

// Ejemplo de uso:
// Nota: Esta biblioteca contiene solo la lógica de validación. Los ejemplos
// de uso deben hacerse desde `main.dart` u otro módulo que importe esta
// función.

/// Ejecuta ejemplos de uso de la lógica del Punto 2 (validación de contraseñas).
///
/// Agrupa las pruebas y las impresiones para mantener la demo junto a la
/// implementación.
void demoPunto2() {
  final pruebas = {
    'Contrasena123!': 'válida',
    'Cort1!': 'inválida (corta)',
    'contrasena123!': 'inválida (sin mayúscula)',
    'Contrasena123': 'inválida (sin especial)',
  };

  for (final entry in pruebas.entries) {
    final esValida = validarContrasena(entry.key);
    print(
      "'${entry.key}' es ${esValida ? 'válida' : 'inválida'} (esperado: ${entry.value})",
    );
  }
}

// ignore_for_file: avoid_print
/// Permite ejecutar directamente este archivo: `dart run .\lib\EJERCICIOS\punto2_core.dart`
void main(List<String> args) {
  demoPunto2();
}
