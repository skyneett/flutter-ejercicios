// ignore_for_file: avoid_print
/// Define los tipos de unidades de temperatura.
enum TemperatureUnit { celsius, fahrenheit, kelvin }

/// Clase que maneja todas las operaciones de conversión de temperatura.
class TemperatureConverter {
  final double value;
  final TemperatureUnit fromUnit;

  TemperatureConverter(this.value, this.fromUnit);

  /// Convierte la temperatura actual a la unidad deseada.
  double convertTo(TemperatureUnit toUnit) {
    // 1. Convertir la temperatura inicial a una base común (Celsius)
    double celsius = _convertToCelsius(value, fromUnit);

    // 2. Convertir de la base común (Celsius) a la unidad destino
    return _convertFromCelsius(celsius, toUnit);
  }

  /// Función interna para convertir cualquier unidad a Celsius.
  double _convertToCelsius(double temp, TemperatureUnit unit) {
    switch (unit) {
      case TemperatureUnit.celsius:
        return temp;
      case TemperatureUnit.fahrenheit:
        // C = (F - 32) * 5/9
        return (temp - 32) * 5 / 9;
      case TemperatureUnit.kelvin:
        // C = K - 273.15
        return temp - 273.15;
    }
  }

  /// Función interna para convertir de Celsius a la unidad deseada.
  double _convertFromCelsius(double celsius, TemperatureUnit unit) {
    switch (unit) {
      case TemperatureUnit.celsius:
        return celsius;
      case TemperatureUnit.fahrenheit:
        // F = (C * 9/5) + 32
        return (celsius * 9 / 5) + 32;
      case TemperatureUnit.kelvin:
        // K = C + 273.15
        return celsius + 273.15;
    }
  }

  // Método opcional para un mejor output
  String toStringAs(TemperatureUnit toUnit) {
    final result = convertTo(toUnit);
    final unitSymbol = _getUnitSymbol(toUnit);
    final fromSymbol = _getUnitSymbol(fromUnit);

    // Muestra solo dos decimales para mayor claridad
    return '${value.toStringAsFixed(2)}$fromSymbol = ${result.toStringAsFixed(2)}$unitSymbol';
  }

  // Utilidad para obtener el símbolo de la unidad
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
}

// -------------------------------------------------------------

/// Ejecuta ejemplos de uso del Punto 4 (conversión de temperaturas).
void demoPunto4() {
  // Ejemplos de uso

  // 🌡️ 25°C a Fahrenheit y Kelvin
  final c1 = TemperatureConverter(25.0, TemperatureUnit.celsius);
  print(c1.toStringAs(TemperatureUnit.fahrenheit));
  print(c1.toStringAs(TemperatureUnit.kelvin));

  // 🌡️ 32°F (punto de congelación) a Celsius y Kelvin
  final f1 = TemperatureConverter(32.0, TemperatureUnit.fahrenheit);
  print(f1.toStringAs(TemperatureUnit.celsius));
  print(f1.toStringAs(TemperatureUnit.kelvin));

  // 🌡️ 273.15 K (punto de congelación) a Celsius y Fahrenheit
  final k1 = TemperatureConverter(273.15, TemperatureUnit.kelvin);
  print(k1.toStringAs(TemperatureUnit.celsius));
  print(k1.toStringAs(TemperatureUnit.fahrenheit));

  // 🌡️ -40°F a Celsius (el punto donde son iguales)
  final f2 = TemperatureConverter(-40.0, TemperatureUnit.fahrenheit);
  print(f2.toStringAs(TemperatureUnit.celsius));
}

/// Permite ejecutar este archivo directamente desde `lib`:
/// `dart run .\lib\EJERCICIOS\Punto4_core.dart`
void main(List<String> args) {
  demoPunto4();
}
