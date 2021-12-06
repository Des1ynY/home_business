class AppUser {
  AppUser._privateConstructor();

  static final AppUser _instance = AppUser._privateConstructor();

  factory AppUser() {
    return _instance;
  }

  String name = 'unknown';
  String surname = 'unknown';
  String bio = 'unknown';
  String birthday = 'unknown';
  String phone = 'unknown';
  String city = 'unknown';
  String street = 'unknown';
  String home = 'unknown';
  String approach = 'unknown';
  String apartment = 'unknown';

  void setUser(Map<String, String> data) {
    name = data['name']!;
    surname = data['surname']!;
    bio = data['bio']!;
    birthday = data['birthday']!;
    phone = data['phone']!;
    city = data['city']!;
    street = data['street']!;
    home = data['home']!;
    approach = data['approach']!;
    apartment = data['apartment']!;
  }

  Map<String, String> toJson() {
    return {
      'name': name,
      'surname': surname,
      'bio': bio,
      'birthday': birthday,
      'phone': phone,
      'city': city,
      'street': street,
      'home': home,
      'approach': approach,
      'apartment': apartment,
    };
  }

  List<String> getFields() {
    return [
      'name',
      'surname',
      'bio',
      'birthday',
      'phone',
      'city',
      'street',
      'home',
      'approach',
      'apartment',
    ];
  }
}
