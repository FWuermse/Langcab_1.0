class Word {

  final int wordId;
  String wordEnglish;
  String wordPinyin;
  String wordChinese;
  String language;

  Word(this.wordId, this.wordEnglish, this.wordPinyin, this.wordChinese, this.language);

  factory Word.fromJson(Map<String, dynamic> word) => new Word(_toInt(
      word['wordId']),
      word['wordEnglish'],
      word['wordPinyin'],
      word['wordChinese'],
      word['language']);

  Map toJson() => {
    'wordId': wordId,
    'wordEnglish': wordEnglish,
    'wordPinyin': wordPinyin,
    'wordChinese': wordChinese,
    'language': language};
}

int _toInt(wordId) => wordId is int ? wordId : int.parse(wordId);