import 'img_assets.dart';

class AppString {
  AppString._();

  static final String tabletTxt = 'Tablet';
  static final String capsuleTxt = 'Capsule';
  static final String creamTxt = 'Cream';
  static final String liquidTxt = 'Liquid';

  static final Map<String, String> imgWithText = {
    tabletTxt: Assets.tabeltImg,
    capsuleTxt: Assets.capsuleImg,
    creamTxt: Assets.creamImg,
    liquidTxt: Assets.liquidImg,
  };

  static final List<String> pillOptions = [
    "¼ Pill",
    "½ Pill",
    "1 Pill",
    "2 Pills",
    "3 Pills",
    "4 Pills"
  ];
  static final List<String> liquidOptions = [
    "1 ml",
    "2 ml",
    "5 ml",
    "10 ml",
    "15 ml",
    "25 ml",
    "50 ml",
    "100 ml"
  ];

  List<String> foodOptions = ["Before Food", "After Food", "Before Sleep"];
}
