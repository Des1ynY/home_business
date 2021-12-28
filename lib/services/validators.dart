class Validator {
  static String? phone(String? phone) {
    if (phone == null || phone.isEmpty) return 'Укажите номер';
    if (phone.length < 11) return 'Неправильно набран номер';

    String pattern =
        r'(^((8|\+7)[\- ]?)?\(?\d{3,5}\)?[\- ]?\d{1}[\- ]?\d{1}[\- ]?\d{1}[\- ]?\d{1}[\- ]?\d{1}(([\- ]?\d{1})?[\- ]?\d{1})?$)';

    return !RegExp(pattern).hasMatch(phone) ? 'Неправильно набран номер' : null;
  }

  static String? name(String? value) {
    String pattern =
        r"^[а-яА-Яa-zA-Z]+(([',. -][а-яА-Яa-zA-Z ])?[а-яА-Яa-zA-Z]*)*$";
    RegExp regex = RegExp(pattern);

    return !regex.hasMatch(value!) ? '' : null;
  }

  static String? number(String? value) {
    String pattern = r'^[0-9]+$';
    RegExp regex = RegExp(pattern);

    return !regex.hasMatch(value!) ? '' : null;
  }

  static String? notEmpty(String? value) {
    String pattern = r'^\S+$';
    RegExp regex = RegExp(pattern);

    return !regex.hasMatch(value!.trim()) ? '' : null;
  }
}
