class LectureThingToBring {
  final String name;

  const LectureThingToBring({
    required this.name,
  });

  @override
  bool operator ==(Object other) => other is LectureThingToBring && other.name == name;

  @override
  int get hashCode => name.hashCode;
}