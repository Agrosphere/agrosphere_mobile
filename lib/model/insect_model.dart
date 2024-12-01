class InsectGroup {
  String id;
  int count;
  List<Insect> insects;

  InsectGroup({
    required this.id,
    required this.count,
    required this.insects,
  });

  factory InsectGroup.fromJson(Map<String, dynamic> json) {
    return InsectGroup(
      id: json['_id'],
      count: json['count'],
      insects: List<Insect>.from(
        json['insects'].map((insect) => Insect.fromJson(insect)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'count': count,
      'insects': insects.map((insect) => insect.toJson()).toList(),
    };
  }
}

class Insect {
  String id;
  String type;
  String name;
  String image;
  List<String> damage;
  List<String> management;

  Insect({
    required this.id,
    required this.type,
    required this.name,
    required this.image,
    required this.damage,
    required this.management,
  });

  factory Insect.fromJson(Map<String, dynamic> json) {
    return Insect(
      id: json['_id'],
      type: json['type'],
      name: json['name'],
      image: json['image'],
      damage: List<String>.from(json['Damage']),
      management: List<String>.from(json['management']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'type': type,
      'name': name,
      'image': image,
      'Damage': damage,
      'management': management,
    };
  }
}
