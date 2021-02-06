import 'package:http/http.dart' as http;

import '../../core/shared_prefernces_api.dart';
import '../../main.dart';
import '../../model/notice.dart';

class NoticeApiServices {
  static NoticeApiServices _instance = NoticeApiServices._init();
  NoticeApiServices._init();
  static NoticeApiServices instance = _instance;

  Future<http.Response> getmyNotice(String userId) async {
    Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer  ' + SharedManager().jwtToken};

    final response = http.get(
      baseUrl + 'notice/GetMyNotice/$userId',
      headers: headers,
    );
    return response;
  }

  Future<http.Response> getAllNoticeNoPage() async {
    Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer  ' + SharedManager().tokenNotUser};

    final response = http.get(
      baseUrl + 'notice/GetAll',
      headers: headers,
    );
    return response;
  }

  Future<http.Response> getMyCorporationNotice(String userId, int pageNumber) async {
    Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer  ' + SharedManager().jwtToken};

    final response = http.get(
      baseUrl + 'notice/GetMyCorporationNotice/$userId?PageNumber=$pageNumber&PageSize=3',
      headers: headers,
    );
    return response;
  }

  Future<http.Response> getmyLastNotice(String userId) async {
    Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer  ' + SharedManager().jwtToken};

    final response = http.get(
      baseUrl + 'notice/GetMyLastFiveNotice/$userId',
      headers: headers,
    );
    return response;
  }

  Future<http.Response> getNoticeDetail(String id) {
    Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer  ' + SharedManager().jwtToken};

    final response = http.get(
      baseUrl + 'notice/$id',
      headers: headers,
    );
    return response;
  }

  static Future<http.Response> getAllNotice(int pageNumber) async {
    Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer  ' + SharedManager().jwtToken};

    final response = http.get(
      baseUrl + 'notice?PageNumber=$pageNumber&PageSize=3',
      headers: headers,
    );
    return response;
  }

  Future<http.Response> createNotice(Notice notice) async {
    Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer  ' + SharedManager().jwtToken};

    final response = await http.post(baseUrl + 'notice/CreateNotice', headers: headers, body: postToJsonNotice(notice));

    return response;
  }

  Future<http.Response> updateNoticeSuccess(Notice noticeIn) async {
    Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer  ' + SharedManager().jwtToken};

    final response = await http.put(baseUrl + 'notice/UpdateNoticeSuccess/${noticeIn.id}', headers: headers, body: postToJsonNotice(noticeIn));

    return response;
  }

  Future<http.Response> updateNoticeDelete(Notice noticeIn) async {
    Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer  ' + SharedManager().jwtToken};

    final response = await http.put(baseUrl + 'notice/UpdateNoticeDelete/${noticeIn.id}', headers: headers, body: postToJsonNotice(noticeIn));

    return response;
  }

  Future<http.StreamedResponse> createNoticePhoto(String imagePath, String fileName) async {
    var request = http.MultipartRequest("POST", Uri.parse(baseUrl + "Notice/UploadNewsBannerFile?fileName=$fileName"));
    request.headers['Authorization'] = 'Bearer  ' + SharedManager().jwtToken;

    var pic = await http.MultipartFile.fromPath("files", imagePath);
    request.files.add(pic);
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);

    return response;
  }
}
