class AppUser {
  String name = 'unknown';
  String surname = 'unknown';
  String bio = 'unknown';
  String phone = 'unknown';
  String city = 'unknown';
  String street = 'unknown';
  String home = 'unknown';
  String approach = 'unknown';
  String apartment = 'unknown';

  AppUser._privateConstructor();

  static final AppUser _instance = AppUser._privateConstructor();

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'surname': surname,
      'bio': bio,
      'phone': phone,
      'city': city,
      'street': street,
      'home': home,
      'approach': approach,
      'apartment': apartment,
    };
  }

  factory AppUser() {
    return _instance;
  }
}
