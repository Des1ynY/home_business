import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  Order({
    required this.uid,
    required this.title,
    required this.description,
    required this.creationDate,
    required this.authorId,
    required this.price,
    required this.tags,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      uid: json['uid'],
      title: json['title'],
      description: json['description'],
      creationDate: json['creationDate'],
      authorId: json['authorId'],
      price: json['price'],
      tags: json['tags'],
    );
  }

  String uid, title, description, authorId, price;
  Timestamp creationDate;
  List<dynamic> tags;

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'title': title,
      'description': description,
      'creationDate': creationDate,
      'authorId': authorId,
      'price': price,
      'tags': tags,
    };
  }
}
