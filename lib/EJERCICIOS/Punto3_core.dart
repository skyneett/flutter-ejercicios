/// Archivo renombrado a minúsculas para cumplir con las reglas de estilo
/// de Dart (`lower_case_with_underscores`).
///
/// Si este archivo debería contener lógica (ej. funciones o clases para el
/// ejercicio 3), añádela aquí. Por ahora contiene sólo esta nota para evitar
/// avisos del analizador sobre el nombre del archivo.

// Puedes reemplazar este comentario con la implementación requerida.

/// Representa una tarea individual con su estado.
class Task {
  String title;
  String description;
  bool completed;

  // Constructor
  Task({required this.title, this.description = '', this.completed = false});

  // Método para convertir la tarea a una representación de cadena
  @override
  String toString() {
    return '${completed ? '[X]' : '[ ]'} $title: $description';
  }
}

// -------------------------------------------------------------

/// Gestiona una colección de tareas (Task).
class TodoList {
  // Lista privada de tareas
  final List<Task> _tasks = [];

  /// Retorna una copia inmutable de la lista de tareas.
  List<Task> get tasks => List.unmodifiable(_tasks);

  /// Agrega una nueva tarea a la lista.
  void addTask(Task task) {
    _tasks.add(task);
  }

  /// Marca una tarea como completada usando su título.
  /// Retorna true si la tarea fue encontrada y marcada, false en caso contrario.
  bool completeTask(String title) {
    try {
      final task = _tasks.firstWhere((t) => t.title == title);
      task.completed = true;
      return true;
    } catch (e) {
      // Maneja el caso en que no se encuentra la tarea
      return false;
    }
  }

  /// Elimina una tarea de la lista usando su título.
  /// Retorna true si la tarea fue encontrada y eliminada, false en caso contrario.
  bool deleteTask(String title) {
    // Es necesario verificar la longitud antes y después,
    // ya que List.removeWhere() retorna void.
    final initialLength = _tasks.length;

    // removeWhere se ejecuta y modifica la lista
    _tasks.removeWhere((task) => task.title == title);

    // Retorna true si la longitud de la lista disminuyó
    return _tasks.length < initialLength;
  }

  /// Filtra y retorna las tareas basadas en el estado de completado.
  /// Si [isCompleted] es true, retorna tareas completadas; si es false, retorna pendientes.
  List<Task> filterTasks(bool isCompleted) {
    return _tasks.where((task) => task.completed == isCompleted).toList();
  }
}

// -------------------------------------------------------------

/// Función principal para probar las clases.
void main() {
  final todoList = TodoList();

  print("--- 📝 Agregando Tareas ---");
  todoList.addTask(
    Task(title: "Hacer ejercicio", description: "30 minutos de cardio"),
  );
  todoList.addTask(Task(title: "Comprar víveres"));
  todoList.addTask(
    Task(title: "Pagar facturas", completed: true),
  ); // Tarea ya completada

  print("Tareas actuales (${todoList.tasks.length}):");
  todoList.tasks.forEach(print);

  print("\n--- ✅ Completando Tarea ---");
  bool completada = todoList.completeTask("Comprar víveres");
  print("Tarea 'Comprar víveres' marcada como completada: $completada");

  print("\n--- 🔍 Filtrando Tareas Pendientes ---");
  final pendientes = todoList.filterTasks(false);
  pendientes.forEach(print);

  print("\n--- 🗑️ Eliminando Tarea ---");
  bool eliminada = todoList.deleteTask("Hacer ejercicio");
  print("Tarea 'Hacer ejercicio' eliminada: $eliminada");

  print("\n--- Lista Final ---");
  todoList.tasks.forEach(print);
}
