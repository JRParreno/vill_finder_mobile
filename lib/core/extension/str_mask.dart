extension MaskWordsExtension on String {
  // Function to mask words in the string
  String maskWords({String maskChar = '*'}) {
    // Split the string into words
    List<String> words = split(' ');

    // Map over each word and mask them
    List<String> maskedWords = words.map((word) {
      if (word.length > 1) {
        // Show first letter, mask the rest
        return word[0] + maskChar * (word.length - 1);
      } else {
        // Leave single-letter words as they are
        return word;
      }
    }).toList();

    // Join the masked words back into a string
    return maskedWords.join(' ');
  }
}
