class Settings {
  final String theme;

  Settings({this.theme});

  Settings.fromJson(Map<String, dynamic> map)
      : theme = (map ?? const {})['theme'] ?? 'default';

  Map<String, dynamic> toJson() {
    return {
      'theme' : theme,
    };
  }
}