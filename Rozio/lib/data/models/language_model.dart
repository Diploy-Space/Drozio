class LanguageModel {
  final String id;
  final String nativeName;
  final String englishName;

  const LanguageModel({
    required this.id,
    required this.nativeName,
    required this.englishName,
  });

  static const List<LanguageModel> supportedLanguages = [
    LanguageModel(id: 'en', nativeName: 'English', englishName: 'English'),
    LanguageModel(id: 'hi', nativeName: 'हिन्दी', englishName: 'Hindi'),
    LanguageModel(id: 'mr', nativeName: 'मराठी', englishName: 'Marathi'),
    LanguageModel(id: 'bn', nativeName: 'বাংলা', englishName: 'Bengali'),
    LanguageModel(id: 'ta', nativeName: 'தமிழ்', englishName: 'Tamil'),
    LanguageModel(id: 'te', nativeName: 'తెలుగు', englishName: 'Telugu'),
    LanguageModel(id: 'gu', nativeName: 'ગુજરાતી', englishName: 'Gujarati'),
    LanguageModel(id: 'kn', nativeName: 'ಕನ್ನಡ', englishName: 'Kannada'),
  ];
}
