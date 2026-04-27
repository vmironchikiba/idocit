import 'package:idocit/common/providers/theme_provider.dart';

class AppSettingsData {
  final ThemeStyleType? themeType;
  final bool? isCharlesProxyEnabled;
  final String? proxyIP;
  final bool? screenlockIsEnabled;

  const AppSettingsData({this.themeType, this.isCharlesProxyEnabled, this.proxyIP, this.screenlockIsEnabled});
}
