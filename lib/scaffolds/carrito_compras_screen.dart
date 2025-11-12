import 'package:flutter/material.dart';
import '../EJERCICIOS/Punto6_core.dart';

class CarritoComprasScreen extends StatefulWidget {
  const CarritoComprasScreen({super.key});

  @override
  State<CarritoComprasScreen> createState() => _CarritoComprasScreenState();
}

class _CarritoComprasScreenState extends State<CarritoComprasScreen> {
  final _cart = ShoppingCart();
  final _nombreController = TextEditingController();
  final _precioController = TextEditingController();
  double _descuento = 0.0;

  @override
  void dispose() {
    _nombreController.dispose();
    _precioController.dispose();
    super.dispose();
  }

  void _agregarProducto() {
    final nombre = _nombreController.text;
    final precio = double.tryParse(_precioController.text);

    if (nombre.isEmpty || precio == null || precio <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor ingrese datos válidos')),
      );
      return;
    }

    setState(() {
      _cart.addProduct(Product(name: nombre, price: precio));
      _nombreController.clear();
      _precioController.clear();
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$nombre agregado al carrito')));
  }

  void _aplicarDescuento() {
    setState(() {
      _cart.applyDiscount(_descuento / 100);
    });
  }

  @override
  Widget build(BuildContext context) {
    final subtotal = _cart.calculateSubtotal();
    final subtotalNeto = _cart.calculateSubtotalAfterDiscount();
    final total = _cart.calculateTotal();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito de Compras'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.shopping_cart, size: 80, color: Colors.green),
            const SizedBox(height: 32),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Agregar Producto',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _nombreController,
                      decoration: const InputDecoration(
                        labelText: 'Nombre del producto',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.shopping_bag),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _precioController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Precio',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.attach_money),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _agregarProducto,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text('Agregar al Carrito'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Descuento',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Slider(
                            value: _descuento,
                            min: 0,
                            max: 50,
                            divisions: 10,
                            label: '${_descuento.toStringAsFixed(0)}%',
                            onChanged: (value) {
                              setState(() {
                                _descuento = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 60,
                          child: Text(
                            '${_descuento.toStringAsFixed(0)}%',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: _aplicarDescuento,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text('Aplicar Descuento'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 4,
              color: Colors.green[50],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Resumen de Compra',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(height: 24),
                    _buildResumenRow('Subtotal:', subtotal),
                    _buildResumenRow(
                      'Descuento (${(_cart.discountRate * 100).toStringAsFixed(0)}%):',
                      -(subtotal - subtotalNeto),
                      color: Colors.orange,
                    ),
                    _buildResumenRow('Subtotal Neto:', subtotalNeto),
                    _buildResumenRow(
                      'Impuesto (${(_cart.taxRate * 100).toStringAsFixed(0)}%):',
                      total - subtotalNeto,
                      color: Colors.blue,
                    ),
                    const Divider(height: 24),
                    _buildResumenRow('TOTAL A PAGAR:', total, isTotal: true),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResumenRow(
    String label,
    double value, {
    bool isTotal = false,
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            '\$${value.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: isTotal ? 22 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: color ?? (isTotal ? Colors.green : Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
