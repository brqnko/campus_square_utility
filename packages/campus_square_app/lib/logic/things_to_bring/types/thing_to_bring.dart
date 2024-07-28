class ThingToBring {
  final String name;
  final String lectureName;
  // TODO: Implement this
  // final bool isPacked;

  ThingToBring({
    required this.name,
    required this.lectureName,
    // required this.isPacked,
  });

  @override
  bool operator ==(Object other) => other is ThingToBring && other.name == name && other.lectureName == lectureName;

  @override
  int get hashCode => name.hashCode ^ lectureName.hashCode;
}