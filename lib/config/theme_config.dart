import '../utils/utils.dart';

//all of this will be modified when i get the color pallette

class AppThemeConfig {
  AppThemeConfig._privateRepository();

  static final AppThemeConfig instance = AppThemeConfig._privateRepository();

  final ThemeData _themeData =
      ThemeData(fontFamily: 'Grotesk', primaryColor: const Color(0xff3a4f78));

  ThemeData get themeData => _themeData;

  final Color _primaryColor = const Color(0xff2B365A);
  final Color _secondaryColor = const Color(0xffffffff);
  final Color _blackColor = const Color(0xff000000);
  final Color _scaffoldBg = const Color(0xfffbfdfe);

  Color get primaryColor => _primaryColor;
  Color get secondaryColor => _secondaryColor;
  Color get blackColor => _blackColor;
  Color get scaffoldBg => _scaffoldBg;
}
