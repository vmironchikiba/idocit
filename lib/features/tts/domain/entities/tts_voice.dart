class TtsVoice {
  final String name;
  final String locale;
  final String quality;

  const TtsVoice({required this.name, required this.locale, required this.quality});
  factory TtsVoice.fromJson(Map<String, dynamic> json) {
    return TtsVoice(name: json['name'], locale: json['locale'], quality: json['quality']);
  }
  Map<String, String> toJson() {
    final json = <String, String>{};
    json[r'name'] = name;
    json[r'locale'] = locale;
    return json;
  }
}
