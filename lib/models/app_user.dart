class AppUser {
  AppUser._privateConstructor();

  static final AppUser _instance = AppUser._privateConstructor();

  factory AppUser() {
    return _instance;
  }

  String uid = 'unknown';
  String name = 'unknown';
  String surname = 'unknown';
  String bio = 'unknown';
  String phone = 'unknown';
  String city = 'unknown';
  String street = 'unknown';
  String home = 'unknown';
  String approach = 'unknown';
  String apartment = 'unknown';
  String imageUrl = 'unknown';

  void setUser(Map<String, String> data) {
    uid = data['uid']!;
    name = data['name']!;
    surname = data['surname']!;
    bio = data['bio']!;
    phone = data['phone']!;
    city = data['city']!;
    street = data['street']!;
    home = data['home']!;
    approach = data['approach']!;
    apartment = data['apartment']!;
    imageUrl = data['imageUrl']!;
  }

  Map<String, String> toJson() {
    return {
      'uid': uid,
      'name': name,
      'surname': surname,
      'bio': bio,
      'phone': phone,
      'city': city,
      'street': street,
      'home': home,
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
      'home',
      'approach',
      'apartment',
      'imageUrl'
    ];
  }
}
