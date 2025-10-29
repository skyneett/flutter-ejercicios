// ignore_for_file: avoid_print
/// Clase que representa un producto individual.
class Product {
  String name;
  double price;
  Product({required this.name, required this.price});
}

// -------------------------------------------------------------

/// Clase que gestiona las operaciones del carrito de compras.
class ShoppingCart {
  final List<Product> _items = [];
  final double taxRate = 0.15; // 15% de impuesto
  double discountRate = 0.0; // Descuento inicial (0%)

  // --- Métodos de Gestión ---

  /// Agrega un producto al carrito.
  void addProduct(Product product) => _items.add(product);

  /// Aplica una tasa de descuento (0.0 a 1.0).
  void applyDiscount(double rate) {
    if (rate >= 0.0 && rate <= 1.0) {
      discountRate = rate;
    }
  }

  // --- Métodos de Cálculo ---

  /// Calcula la suma total de los precios sin descuentos ni impuestos.
  double calculateSubtotal() {
    return _items.fold(0.0, (sum, item) => sum + item.price);
  }

  /// Calcula el subtotal después de aplicar el descuento.
  double calculateSubtotalAfterDiscount() {
    final subtotal = calculateSubtotal();
    return subtotal * (1.0 - discountRate);
  }

  /// Calcula el total final a pagar (Subtotal con descuento + Impuestos).
  double calculateTotal() {
    final subtotalNeto = calculateSubtotalAfterDiscount();
    // Total = Subtotal Neto * (1 + Tasa de Impuesto)
    return subtotalNeto * (1.0 + taxRate);
  }
}

// -------------------------------------------------------------

/// Demo del Punto 6: muestra uso del carrito y cálculos.
void demoPunto6() {
  final cart = ShoppingCart();

  cart.addProduct(Product(name: "Monitor 4K", price: 450.00));
  cart.addProduct(Product(name: "Webcam HD", price: 55.50));

  // Aplicar un 10% de descuento
  cart.applyDiscount(0.10);

  final subtotal = cart.calculateSubtotal();
  final subtotalNeto = cart.calculateSubtotalAfterDiscount();
  final total = cart.calculateTotal();

  print("--- Resumen Rápido ---");
  print("Subtotal (antes de desc.): \$${subtotal.toStringAsFixed(2)}");
  print(
    "Descuento (${(cart.discountRate * 100).toStringAsFixed(0)}%):  -\$${(subtotal - subtotalNeto).toStringAsFixed(2)}",
  );
  print("Subtotal Neto:            \$${subtotalNeto.toStringAsFixed(2)}");
  print(
    "Impuesto (${(ShoppingCart().taxRate * 100).toStringAsFixed(0)}%):        +\$${(total - subtotalNeto).toStringAsFixed(2)}",
  );
  print("Total a Pagar:            \$${total.toStringAsFixed(2)}");
}

/// Permite ejecutar este archivo directamente desde `lib`.
void main(List<String> args) {
  demoPunto6();
}
