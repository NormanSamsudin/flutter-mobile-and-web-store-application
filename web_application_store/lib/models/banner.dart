import 'dart:convert';

class Banner {
  final String id;
  final String image;

  Banner({required this.id, required this.image});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{"_id": id, "image": image};
  }

  String toJson() => json.encode(toMap());

  factory Banner.fromJson(Map<String, dynamic> map) {
    return Banner(
      id: map['_id'] as String,
      image: map['image'] as String,
    );
  }
  
}
