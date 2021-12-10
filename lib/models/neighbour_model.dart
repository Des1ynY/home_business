class Neighbour {
  Neighbour({
    required this.uid,
    required this.name,
    required this.surname,
    required this.bio,
    required this.phone,
    required this.city,
    required this.street,
    required this.building,
    required this.approach,
    required this.apartment,
    required this.imageUrl,
  });

  factory Neighbour.fromJson(Map<String, dynamic> json) {
    return Neighbour(
      uid: json['uid'],
      name: json['name'],
      surname: json['surname'],
      bio: json['bio'],
      phone: json['phone'],
      city: json['city'],
      street: json['street'],
      building: json['building'],
      approach: json['approach'],
      apartment: json['apartment'],
      imageUrl: json['imageUrl'],
    );
  }

  String uid,
      name,
      surname,
      bio,
      phone,
      city,
      street,
      building,
      approach,
      apartment,
      imageUrl;
}
