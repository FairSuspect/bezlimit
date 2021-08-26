class Validators {
  static String? number(String? value) {
    if (value == null || value == '') return "Поле должно быть заполнено";
    int? number = int.tryParse(value);
    if (number == null) return "Только положительные целочисленные значения";
    return null;
  }
}
