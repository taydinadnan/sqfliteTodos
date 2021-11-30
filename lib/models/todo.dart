class Todo implements Comparable {
  final int id;
  final String title;
  final String description;

  const Todo({
    required this.id,
    required this.title,
    required this.description,
  });

  Todo.fromRow(Map<String, Object?> row)
      : id = row['ID'] as int,
        title = row['TITLE'] as String,
        description = row['DESCRIPTION'] as String;

  @override
  int compareTo(other) => other.id.compareTo(id);

  @override
  bool operator ==(covariant Todo other) => id == other.id;

  @override
  int get hashCode => super.hashCode;

  @override
  String toString() =>
      'Person, id = $id, firstName: $title, lastName: $description';
}
