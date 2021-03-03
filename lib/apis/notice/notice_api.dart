import 'package:MufettisWidgetApp/core/core_helper.dart';
import 'package:http/http.dart' as http;
import '../../core/shared_prefernces_api.dart';
import '../../main.dart';
import '../../model/notice.dart';

class NoticeApiServices {
  static final NoticeApiServices _instance = NoticeApiServices._init();
  NoticeApiServices._init();
  static NoticeApiServices instance = _instance;

//Kullanıncın bildirilerini çeken api servisi
  Future<http.Response> getmyNotice(String userId) async {
    final response = http.get(
      baseUrl + 'notice/GetMyNotice/$userId',
      headers: CoreHelper.getHeaderWithJwtToken(),
    );
    return response;
  }

//Tüm bildirileri çeken api servisi
  Future<http.Response> getAllNoticeNoPage() async {
    final response = http.get(
      baseUrl + 'notice/GetAll',
      headers: CoreHelper.getHeaderWithNotUserToken(),
    );
    return response;
  }

//Kullanıncın son 5 bildirilerini çeken api servisi
  Future<http.Response> getmyLastNotice(String userId) async {
    final response = http.get(
      baseUrl + 'notice/GetMyLastFiveNotice/$userId',
      headers: CoreHelper.getHeaderWithJwtToken(),
    );
    return response;
  }

// Bildirilerin detayını çeken api servisi
  Future<http.Response> getNoticeDetail(String id) {
    final response = http.get(
      baseUrl + 'notice/$id',
      headers: CoreHelper.getHeaderWithJwtToken(),
    );
    return response;
  }

//Tüm bildirileri sayfalayarak çeken api servisi
  static Future<http.Response> getAllNotice(int pageNumber) async {
    final response = http.get(
      baseUrl + 'notice?PageNumber=$pageNumber&PageSize=3',
      headers: CoreHelper.getHeaderWithJwtToken(),
    );
    return response;
  }

//Kullanıcının bildirim oluşturmasını sağlayan api servisi
  Future<http.Response> createNotice(Notice notice) async {
    final response = await http.post(baseUrl + 'notice/CreateNotice', headers: CoreHelper.getHeaderWithJwtToken(), body: postToJsonNotice(notice));

    return response;
  }

//Kullanıcının bildirim güncellemesini sağlayan api servisi
  Future<http.Response> updateNoticeSuccess(Notice noticeIn) async {
    final response = await http.put(baseUrl + 'notice/UpdateNoticeSuccess/${noticeIn.id}',
        headers: CoreHelper.getHeaderWithJwtToken(), body: postToJsonNotice(noticeIn));

    return response;
  }

//Kullanıcının bildirim silmesini sağlayan api servisi
  Future<http.Response> updateNoticeDelete(Notice noticeIn) async {
    final response = await http.put(baseUrl + 'notice/UpdateNoticeDelete/${noticeIn.id}',
        headers: CoreHelper.getHeaderWithJwtToken(), body: postToJsonNotice(noticeIn));
    return response;
  }

//Kullanıcının bildirim eklerken resim yüklemesini sağlayan api servisi

  Future<http.StreamedResponse> createNoticePhoto(String imagePath, String fileName) async {
    var request = http.MultipartRequest('POST', Uri.parse(baseUrl + 'Notice/UploadNewsBannerFile?fileName=$fileName'));
    request.headers['Authorization'] = 'Bearer  ' + SharedManager().jwtToken;

    var pic = await http.MultipartFile.fromPath('files', imagePath);
    request.files.add(pic);
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);

    return response;
  }
}
