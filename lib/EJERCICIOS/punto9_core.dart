// ignore_for_file: avoid_print
/// Clase Book: representa un libro.
class Book {
  String title;
  String isbn;
  bool isAvailable;
  Book({required this.title, required this.isbn, this.isAvailable = true});
}

// -------------------------------------------------------------

/// Clase Member: representa un miembro.
class Member {
  String name;
  int id;
  // Solo guardamos los ISBNs prestados para mantenerlo simple.
  final List<String> borrowedIsbns = [];
  Member({required this.name, required this.id});
}

// -------------------------------------------------------------

/// Clase Library: gestiona todo el sistema.
class Library {
  final List<Book> _books = [];
  final List<Member> _members = [];

  void addBook(Book book) => _books.add(book);
  void addMember(Member member) => _members.add(member);

  Book? _findBook(String isbn) => _books.cast<Book?>().firstWhere(
    (b) => b?.isbn == isbn,
    orElse: () => null,
  );
  Member? _findMember(int id) => _members.cast<Member?>().firstWhere(
    (m) => m?.id == id,
    orElse: () => null,
  );

  /// Presta un libro. Retorna true si tiene éxito.
  bool borrowBook(String isbn, int memberId) {
    final book = _findBook(isbn);
    final member = _findMember(memberId);
    if (book == null || member == null || !book.isAvailable) return false;

    book.isAvailable = false;
    member.borrowedIsbns.add(isbn);
    return true;
  }

  /// Devuelve un libro. Retorna true si tiene éxito.
  bool returnBook(String isbn, int memberId) {
    final book = _findBook(isbn);
    final member = _findMember(memberId);
    if (book == null || member == null || !member.borrowedIsbns.contains(isbn))
      return false;

    book.isAvailable = true;
    member.borrowedIsbns.remove(isbn);
    return true;
  }

  /// Retorna una lista de títulos de libros disponibles.
  List<String> get availableTitles =>
      _books.where((b) => b.isAvailable).map((b) => b.title).toList();
}

// -------------------------------------------------------------

/// Demo del Punto 9: muestra operaciones básicas del sistema de biblioteca.
void demoPunto9() {
  final lib = Library();
  final b1 = Book(title: "Cien años", isbn: "A1");
  final m1 = Member(name: "Ana", id: 1);

  lib.addBook(b1);
  lib.addMember(m1);

  // Préstamo
  print('Libro prestado: ${lib.borrowBook("A1", 1)}'); // true
  print('Disponibles: ${lib.availableTitles}'); // []

  // Devolución
  print('Libro devuelto: ${lib.returnBook("A1", 1)}'); // true
  print('Disponibles: ${lib.availableTitles}'); // [Cien años]
}

/// Permite ejecutar este archivo directamente: `dart run .\lib\EJERCICIOS\punto9_core.dart`
void main(List<String> args) {
  demoPunto9();
}
