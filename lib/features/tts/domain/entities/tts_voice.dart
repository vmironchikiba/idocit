import 'package:equatable/equatable.dart';

class TtsVoice extends Equatable {
  final String name;
  final String locale;
  final String quality;

  const TtsVoice({required this.name, required this.locale, required this.quality});
  factory TtsVoice.fromJson(Map<dynamic, dynamic> json) {
    return TtsVoice(name: json['name'], locale: json['locale'], quality: json['quality']);
  }
  static TtsVoice get nullVoice => TtsVoice(name: '', locale: '', quality: '');
  TtsVoice? get optional => this == TtsVoice.nullVoice ? null : this;

  Map<String, String> toJson() {
    final json = <String, String>{};
    json[r'name'] = name;
    json[r'locale'] = locale;
    json[r'quality'] = quality;
    return json;
  }

  @override
  List<Object?> get props => [name, locale, quality];
}
