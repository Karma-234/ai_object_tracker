extension StringExtension on String {
  String get png => "assets/images/$this.png";

  capitalizeFirstLetter() =>
      isEmpty ? this : replaceRange(0, 1, this[0].toUpperCase());

  sentenceCase() {
    var newString = this[0].toUpperCase();
    return replaceRange(0, 1, newString);
  }
}
