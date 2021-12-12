class AppUser {
  AppUser._privateConstructor();

  static final AppUser _instance = AppUser._privateConstructor();

  factory AppUser() {
    return _instance;
  }

  static String uid = 'unknown';
  static String name = 'unknown';
  static String surname = 'unknown';
  static String bio = 'unknown';
  static String phone = 'unknown';
  static String city = 'unknown';
  static String street = 'unknown';
  static String building = 'unknown';
  static String approach = 'unknown';
  static String apartment = 'unknown';
  static String imageUrl = 'unknown';

  static void setUser(Map<String, dynamic> data) {
    uid = data['uid']!;
    name = data['name']!;
    surname = data['surname']!;
    bio = data['bio']!;
    phone = data['phone']!;
    city = data['city']!;
    street = data['street']!;
    building = data['building']!;
    approach = data['approach']!;
    apartment = data['apartment']!;
    imageUrl = data['imageUrl']!;
  }

  static Map<String, String> toJson() {
    return {
      'uid': uid,
      'name': name,
      'surname': surname,
      'bio': bio,
      'phone': phone,
      'city': city,
      'street': street,
      'building': building,
      'approach': approach,
      'apartment': apartment,
      'imageUrl': imageUrl,
    };
  }

  static List<String> keys() {
    return [
      'uid',
      'name',
      'surname',
      'bio',
      'phone',
      'city',
      'street',
      'building',
      'approach',
      'apartment',
      'imageUrl'
    ];
  }
}
