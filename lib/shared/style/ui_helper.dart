import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../ui/widget/spaceView.dart';

class UIHelper {
  static final String createAccount = 'Create\nAccount';
  static final String welcomeBack = 'Welcome\nBack';
  static final String goOn = 'Devam';
  static final String name = 'Name';
  static final String hello = 'Merhaba';
  static final String email = 'E-posta';
  static final String nameSurname = 'Ad Soyad';
  static final String username = 'Username';
  static final String password = 'Şifre';
  static final String changePassword = 'Şifre Değiştirme';
  static final String customInfo = 'Üye Bilgilerim';
  static final String oldPassword = 'Mevcut Şifre';
  static final String phone = 'Telefon';
  static final String passwordAgain = 'Şifre Tekrar';
  static final String login = 'Login';
  static final String signIn = 'Giriş';
  static final String mainPage = 'Ana Sayfa';
  static final String myNotice = 'Bildirimlerim';
  static final String newNotice = 'Yeni Bildiri';
  static final String save = 'Kaydet';
  static final String repairSuccess = 'Bildirimi Güncelle';
  static final String signUp = 'Üye Ol';
  static final String signInLower = 'Sign in';
  static final String signUpLower = 'Sign up';
  static final String stayLoggedIn = 'Stay Logged In';
  static final String forgetPassword = 'Şifremi Unuttum ?';
  static final String loginSpotify = 'LOG IN WITH SPOTIFY ';
  static final String loginFacebook = 'Login with Facebook';
  static final String emailRequired = 'Email is required';
  static final String passwordRequired = 'Password is required';
  static final String dontHaveAnAccount = 'Hesabın Yokmu ? Kayıt Ol!';
  static final String haveAnAccount = 'Hesabın Varmı ? Giriş Yap!';
  static final String signAccount = 'Bildirim Yapmak için Giriş Yapın';
  static final String signUpAccount = 'Daha yaşanabilir hayat için üye olun!';
  static final String forgatPasswordAccount = 'E-posta adresinizi yazarak şifre yenileyebilirsiniz.';
  static final String renewPasswordAccount = 'Yeni şifrenizi burdan girebilirsiniz.';

  static final String changPasswprdExplanation = 'Mevcutta olan Şifreniz ile birlikte şifrenizi yenileyebilirsiniz.';

  static final String changeInfoStatus = 'Üyelik bilgilerinizi güncelleyebilirsiniz.';

  static const Color PEAR_PRIMARY_COLOR = Color(0xff276678);

  static const Color WHITE = Colors.white;

  static num dynamicHeight(double height) => ScreenUtil.instance.setHeight(height);
  static num dynamicWidth(double width) => ScreenUtil.instance.setWidth(width);
  static num dynamicSp(double fontsize) => ScreenUtil.instance.setSp(fontsize);

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

  static Widget horizontalSpaceSmall() {
    return horizontalSpace(_HorizontalSpaceSmall);
  }

  static Widget horizontalSpaceMedium() {
    return horizontalSpace(_HorizontalSpaceMedium);
  }

  static Widget horizontalSpaceLarge() {
    return horizontalSpace(HorizontalSpaceLarge);
  }

  static Widget horizontalSpace(double width) {
    return SpaceView(width: width);
  }
}
