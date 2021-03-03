import 'shared_prefernces_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class CoreHelper {
  static final validCharacters = RegExp(r'^[a-zA-Z]+$');

  static const String kGoogleApiKey = 'AIzaSyALnT7pxhQRDuQ3X5RdHEFfUbGtr4w7VL8';

  static String dateTimeParser(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  static String parseDateData(String dateData) {
    var formater = DateFormat('yyy-MM-dd hh:mm');
    return formater.format(DateTime.parse(dateData));
  }

  static DateTime stringToDate(String strDate) {
    var convertedDate = DateFormat('dd/MM/yyyy').parse(strDate);
    return convertedDate;
  }

  static Map<String, String> getHeaderWithJwtToken() {
    var headers = <String, String>{'Content-Type': 'application/json', 'Authorization': 'Bearer  ' + SharedManager().jwtToken};
    return headers;
  }

  static Map<String, String> getHeaderWithNotUserToken() {
    var headers = <String, String>{'Content-Type': 'application/json', 'Authorization': 'Bearer  ' + SharedManager().tokenNotUser};
    return headers;
  }

  static LatLngBounds boundsFromLatLngList(List<LatLng> list) {
    double x0, x1, y0, y1;
    for (var latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1) y1 = latLng.longitude;
        if (latLng.longitude < y0) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(northeast: LatLng(x1, y1), southwest: LatLng(x0, y0));
  }

  // ignore: always_declare_return_types
  static unFocus(context) async {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static Color getColor(status) {
    if ((status & (64) == 64) || (status & (128) == 128)) {
      return Colors.red;
    } else {
      return CupertinoColors.systemGrey;
    }
  }

  // ignore: missing_return
  static String getStatus(int status) {
    if (status & 8 == 8) {
      return 'İl Belediyesine Atandı.';
    } else if (status & 16 == 16) {
      return 'İlçe Belediyesine Atandı.';
    } else if (status & 64 == 64) {
      return 'Belediye tarafından bildirim düzeltildi. Kontrol bekliyor.';
    } else if (status & 128 == 128) {
      return 'Kullanıcı onayladı';
    } else if (status & 256 == 256) {
      return 'Belediye tarafından Sorun giderildi. Editör Onayladı.';
    } else if (status & 1 == 1) return 'İşlem Bekliyor';
  }
}
