// ignore_for_file: avoid_print
/// Clase Base: Persona
abstract class Person {
  String name;
  // Constructor con parámetro CON NOMBRE
  Person({required this.name});

  String getRole();
  void introduce() {
    print("Soy $name. Mi rol: ${getRole()}.");
  }
}

// -------------------------------------------------------------

/// Clase Derivada: Estudiante
class Student extends Person {
  int studentId;
  // Usa la sintaxis de super con parámetros CON NOMBRE
  Student({required super.name, required this.studentId});

  @override
  String getRole() => 'Estudiante';
}

// -------------------------------------------------------------

/// Clase Derivada: Profesor
class Teacher extends Person {
  String subject;
  // Usa la sintaxis de super con parámetros CON NOMBRE
  Teacher({required super.name, required this.subject});

  @override
  String getRole() => 'Profesor de $subject';
}

// -------------------------------------------------------------

/// Clase de Gestión: Aula
class Classroom {
  final List<Person> members = [];

  void addMember(Person person) {
    members.add(person);
  }

  void listMembers() {
    print("\n--- Miembros del Aula ---");
    for (var member in members) {
      member.introduce();
    }
  }

  void countRoles() {
    int students = members.whereType<Student>().length;
    int teachers = members.whereType<Teacher>().length;
    print('\nRoles: $students Estudiantes, $teachers Profesores.');
  }
}

// -------------------------------------------------------------

/// Demo del Punto 8: crea una aula con profesor y estudiantes y muestra info.
void demoPunto8() {
  final teacher = Teacher(name: "Dr. Elena García", subject: "Matemáticas");
  final student1 = Student(name: "Luis Torres", studentId: 101);
  final student2 = Student(name: "Ana Soto", studentId: 102);

  final aulaDart = Classroom();
  aulaDart.addMember(teacher);
  aulaDart.addMember(student1);
  aulaDart.addMember(student2);

  aulaDart.listMembers();
  aulaDart.countRoles();
}

/// Permite ejecutar este archivo directamente: `dart run .\lib\EJERCICIOS\Punto8_core.dart`
void main(List<String> args) {
  demoPunto8();
}
