class ValidationMixin {
  String validateFirtsName(String value) {
    if (value.length < 2) {
      return 'İsim en az iki karekter olmalıdır';
    }
    return null;
  }

  String validateLastName(String value) {
    if (value.length < 2) {
      return 'Soyad en az iki karekter olmalıdır';
    }
    return null;
  }

  String validateTckNo(String value) {
    if (value.length != 11) {
      return 'TCK No 11 hane olmalı';
    }
    return null;
  }

  String validateEmail(String value) {
    if (!value.contains('@')) {
      return 'Mail geçerli değildir.';
    }
    return null;
  }

  String validatePassword(String value) {
    if (value.length < 6) {
      return 'Şifre en az 6 karekter olmalı';
    }
    return null;
  }

  String validateExplation(String value) {
    if (value.length < 10) {
      return 'Açıklama en az 10 karekter olmalı';
    }
    return null;
  }

  String validatePhone(String value) {
    if (value.length != 10) {
      return 'Numara 10 hane olmalı';
    }
    return null;
  }
}
