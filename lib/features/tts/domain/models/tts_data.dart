class TtsData {
  TtsData({required this.isEnabled});

  bool isEnabled;

  @override
  bool operator ==(Object other) => identical(this, other) || other is TtsData && other.isEnabled == isEnabled;

  @override
  int get hashCode => isEnabled.hashCode;

  @override
  String toString() => 'UserToken[isEnabled=$isEnabled]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'isEnabled'] = isEnabled;
    return json;
  }
}
