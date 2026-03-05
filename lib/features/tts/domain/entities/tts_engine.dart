import 'package:equatable/equatable.dart';

class TtsEngine extends Equatable {
  final String name;

  const TtsEngine(this.name);

  @override
  List<Object?> get props => [name];
}
