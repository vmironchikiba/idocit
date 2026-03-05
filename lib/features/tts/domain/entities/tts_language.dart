import 'package:equatable/equatable.dart';

class TtsLanguage extends Equatable {
  final String code;

  const TtsLanguage(this.code);

  @override
  List<Object?> get props => [code];
}
