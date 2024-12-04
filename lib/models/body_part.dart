class BodyPart {
  final String name;

  BodyPart({required this.name});

  factory BodyPart.fromJson(String json) {
    return BodyPart(name: json);
  }
}
