class AppUser {
  String name = 'unknown';
  String surname = 'unknown';
  String city = 'unknown';
  String street = 'unknown';
  String home = 'unknown';
  String approach = 'unknown';
  String apartment = 'unknown';

  AppUser._privateConstructor();

  static final AppUser _instance = AppUser._privateConstructor();

  factory AppUser() {
    return _instance;
  }
}
