import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../ui/widget/spaceView.dart';

class UIHelper {
  // STRING
  static final String createAccount = "Create\nAccount";
  static final String welcomeBack = "Welcome\nBack";
  static final String goOn = "Devam";
  static final String name = "Name";
  static final String hello = "Merhaba";
  static final String email = "E-posta";
  static final String nameSurname = "Ad Soyad";
  static final String username = "Username";
  static final String password = "Şifre";
  static final String changePassword = "Şifre Değiştirme";
  static final String customInfo = "Üye Bilgilerim";
  static final String oldPassword = "Mevcut Şifre";
  static final String phone = "Telefon";
  static final String passwordAgain = "Şifre Tekrar";
  static final String login = "Login";
  static final String signIn = "Giriş";
  static final String mainPage = "Ana Sayfa";
  static final String myNotice = "Bildirimlerim";
  static final String newNotice = "Yeni Bildiri";
  static final String save = "Kaydet";
  static final String repairSuccess = "Bildirimi Güncelle";
  static final String signUp = "Üye Ol";
  static final String signInLower = "Sign in";
  static final String signUpLower = "Sign up";
  static final String stayLoggedIn = "Stay Logged In";
  static final String forgetPassword = "Şifremi Unuttum ?";
  static final String loginSpotify = "LOG IN WITH SPOTIFY ";
  static final String loginFacebook = "Login with Facebook";
  static final String emailRequired = "Email is required";
  static final String passwordRequired = "Password is required";
  static final String dontHaveAnAccount = "Hesabın Yokmu ? Kayıt Ol!";
  static final String haveAnAccount = "Hesabın Varmı ? Giriş Yap!";
  static final String signAccount = "Bildirim Yapmak için Giriş Yapın";
  static final String signUpAccount = "Daha yaşanabilir hayat için üye olun!";
  static final String forgatPasswordAccount = "E-posta adresinizi yazarak şifre yenileyebilirsiniz.";
  static final String renewPasswordAccount = "Yeni şifrenizi burdan girebilirsiniz.";

  static final String changPasswprdExplanation = "Mevcutta olan Şifreniz ile birlikte şifrenizi yenileyebilirsiniz.";

  static final String changeInfoStatus = "Üyelik bilgilerinizi güncelleyebilirsiniz.";

  // IMAGES
  static final String muzPhoto = "assets/images/muz_login.png";
  static final String grapePhoto = "assets/images/grape_login.png";
  static final String strawberryPhoto = "assets/images/strawberry_login.png";
  static final String blueberryPhoto = "assets/images/blueberry.png";
  static final String pomegranatePhoto = "assets/images/pomegranate_login.png";
  static final String apricotPhoto = "assets/images/apricot_login.png";
  static final String figPhoto = "assets/images/fig_login.png";
  static final String cherryPhoto = "assets/images/cherry_login.png";
  static final String applePhoto = "assets/images/apple_login.png";
  static final String watermelonPhoto = "assets/images/watermelon_login.png";
  static final String pineapplePhoto = "assets/images/pineapple_login.png";
  static final String pearPhoto = "assets/images/pear_login.png";
  static final String noPhoto = "assets/images/no_photo.png";
  static final String scooter = "assets/drawable/scooter.png";

  // MUZ LOGIN COLORS
  static const Color MUZ_PRIMARY_COLOR = Color(0XFF3C67F7);
  static const Color MUZ_BACKGROUND_COLOR = Color(0xFFF2F3F8);
  static const Color MUZ_SHADOW = Color(0x70000000);
  static const Color MUZ_BUTTONSHADOW = Color(0x403C67F7);
  static const Color MUZ_TEXT_COLOR = Color(0xFF5A7BB5);

  // STRAWBERRY LOGIN COLORS
  static const Color STRAWBERRY_PRIMARY_COLOR = Color(0xFFFE0000);
  static const Color STRAWBERRY_SECONDARY_COLOR = Color(0xFFC40000);
  static const Color STRAWBERRY_SHADOW = Color(0x70000000);
  static const Color STRAWBERRY_BUTTONSHADOW = Color(0x403C67F7);
  static const Color STRAWBERRY_TEXT_COLOR = Color(0xFF5A7BB5);
  static const Color STRAWBERRY_FOCUS_COLOR = Color(0xFFFF5A35);

  // BLUEBERRY LOGIN COLORS
  static const Color BLUEBERRY_BLUE = Color(0xFF4D7DF9);
  static const Color BLUEBERRY_BLACK = Color(0xFF222222);
  static const Color BLUEBERRY_ORANGE = Color(0xFFFFD164);
  static const Color BLUEBERRY_GREY = Color(0xFFF7F9FA);
  static const Color BLUEBERRY_TEXT_COLOR = Color(0xFFBBC3CE);

  // POMEGRANATE LOGIN COLORS
  static const Color POMEGRANATE_PRIMARY_COLOR = Color(0xFFFF5E7A);
  static const Color POMEGRANATE_SHADOW_COLOR = Color(0x60FF5E7A);
  static const Color POMEGRANATE_TEXT_COLOR = Color(0xFF6D7278);

  // APRICOT LOGIN COLORS
  static const Color APRICOT_PRIMARY_COLOR = Color(0xFFFEB209);
  static const Color APRICOT_SHADOW_COLOR = Color(0x60FF5E7A);
  static const Color APRICOT_TEXT_COLOR = Color(0xFFC2C2C2);

  // FIG LOGIN COLORS
  static const Color FIG_PRIMARY_COLOR = Color(0xFF182058);
  static const Color FIG_SECONDARY_COLOR = Color(0xFFE03E3E);
  static const Color FIG_SHADOW_COLOR = Color(0x60FF5E7A);
  static const Color FIG_TEXT_COLOR = Color(0xFF9E9D9D);
  static const Color FIG_FORGET_TEXT_COLOR = Color(0xFF38B5F2);

  // CHERRY LOGIN COLORS
  static const Color CHERRY_PRIMARY_COLOR = Color(0xFF1566E0);
  static const Color CHERRY_INPUT_TEXT_COLOR = Color(0xFF1EA5FF);

  // APPLE LOGIN COLORS
  static const Color APPLE_GRADIENT_COLOR_ONE = Color(0xFFFBC79A);
  static const Color APPLE_GRADIENT_COLOR_TWO = Color(0xFFDD5671);

  // WATERMELON LOGIN COLORS
  static const Color WATERMELON_PRIMARY_COLOR = Color(0xFFC72C41);
  static const Color WATERMELON_SHADOW = Color(0x40C72C41);

  // PINEAPPLE LOGIN COLOR
  static const Color PINEAPPLE_PRIMARY_COLOR = Color(0xFF71CEEB);
  static const Color PINEAPPLE_SECONDARY_COLOR = Color(0xFFF1F0F2);
  static const Color PINEAPPLE_SHADOW = Color(0x30000000);

  // PEAR LOGIN COLOR
  static const Color PEAR_PRIMARY_COLOR = Color(0xFF4873FF);

  // AVOCADOS LOGIN COLOR
  static const Color AVOCADOS_PRIMARY_COLOR = Color(0xFF0B5D47);
  static const Color AVOCADOS_SECONDARY_COLOR = Color(0xFFFEA839);

  // GLOBAL COLORS
  static const Color SPOTIFY_COLOR = Color(0xFF1DB954);
  static const Color SPOTIFY_TEXT_COLOR = Color(0xFFF4F6FC);
  static const Color SPOTIFY_SHADOW = Color(0x401DB954);
  static const Color WHITE = Colors.white;
  static const Color BLACK = Colors.black;
  static const Color THEME_PRIMARY = Color(0XFF575C79);
  static const Color THEME_LIGHT = Color(0XFF8489A8);
  static const Color THEME_DARK = Color(0XFF2D334D);
  static const Color BACKGROUND_COLOR = Color(0XFFAEB2D1);
  static const Color FACEBOOK_COLOR = Color(0xFFF3B5998);

  // SPACE
  static dynamicHeight(double height) => ScreenUtil.instance.setHeight(height);
  static dynamicWidth(double width) => ScreenUtil.instance.setWidth(width);
  static dynamicSp(double fontsize) => ScreenUtil.instance.setSp(fontsize);

  static const double Space0 = 0;
  static const double Space5 = 5.0;
  static const double Space10 = 10.0;
  static const double Space15 = 15.0;
  static const double Space20 = 20.0;
  static const double Space25 = 25.0;
  static const double Space30 = 30.0;
  static const double Space40 = 40.0;
  static const double Space45 = 45.0;

  static const double Space50 = 50.0;
  static const double Space55 = 55.0;
  static const double Space60 = 60.0;
  static const double Space72 = 72.0;
  static const double Space100 = 100.0;
  static const double Space120 = 120.0;
  static const double Space150 = 150.0;
  static const double Space200 = 200.0;
  static const double Space250 = 250.0;
  static const double Space275 = 275.0;
  static const double Space300 = 300.0;
  static const double Space350 = 350.0;
  static const double Space400 = 400.0;
  static const double Space450 = 450.0;
  static const double Space500 = 500.0;
  static const double Space600 = 600.0;
  static const double Space700 = 700.0;
  static const double Space750 = 750.0;
  static const double Space800 = 800.0;
  static const double Space1300 = 1300.0;
  static const double Space1500 = 1500.0;

  static Widget verticalSpaceSmall() {
    return verticalSpace(_VerticalSpaceSmall);
  }

  static const double _VerticalSpaceSmall = 10.0;

  static const double _HorizontalSpaceSmall = 10.0;
  static const double _HorizontalSpaceMedium = 20.0;
  static const double HorizontalSpaceLarge = 60.0;

  static Widget verticalSpace(double height) {
    return SpaceView(height: height);
  }

  static double dynamicScaleSp(double val) => ScreenUtil(allowFontScaling: true).setSp(val);

  /// Returns a vertical space with height set to [_HorizontalSpaceSmall]
  static Widget horizontalSpaceSmall() {
    return horizontalSpace(_HorizontalSpaceSmall);
  }

  /// Returns a vertical space with height set to [_HorizontalSpaceMedium]
  static Widget horizontalSpaceMedium() {
    return horizontalSpace(_HorizontalSpaceMedium);
  }

  /// Returns a vertical space with height set to [HorizontalSpaceLarge]
  static Widget horizontalSpaceLarge() {
    return horizontalSpace(HorizontalSpaceLarge);
  }

  /// Returns a vertical space equal to the [width] supplied
  static Widget horizontalSpace(double width) {
    return SpaceView(width: width);
  }
}
