import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:home_business/models/app_user.dart';

class ServerStorage {
  static final FirebaseStorage _ref = FirebaseStorage.instance;

  static saveImage(String path, File file) async {
    _ref.ref().child('${AppUser().uid}/$path').putFile(file);
  }
}
