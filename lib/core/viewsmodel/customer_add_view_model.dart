import 'package:MufettisWidgetApp/core/enum/viewstate.dart';
import 'package:MufettisWidgetApp/shared/style/ui_helper.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import '../../apis/account/acoount_api.dart';
import '../../model/user.dart';
import 'base_model.dart';

// Kullanıcının kayıt olması için kullanılan model
class CustomerAddViewModel extends BaseModel {
  final customerAddScaffoldKey = GlobalKey<ScaffoldState>(debugLabel: "_customerAddScaffoldKey");

  BuildContext _context;

  BuildContext get context => _context;

  CustomerAddViewModel() {}
  @override
  void setContext(BuildContext context) {
    this._context = context;
  }

  Future<void> saveCustomer(User user) async {
    bool isConncet = false;

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      isConncet = true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      isConncet = true;
    }
    if (isConncet) {
      AccountApiServices.createUser(user).then((response) {
        setState(ViewState.Busy);
        if (response.statusCode == 201) {
          _showDialog("Kayıdınız alındı. Devamke!", true);
          setState(ViewState.Idle);
        } else {
          _showDialog("Aynı mail adresi veya telefon numarasına ait kayıt vardır.", false);
          setState(ViewState.Idle);
        }
      });
    } else {
      _showDialog("Lütfen internet bağlantınızı kontrol ediniz.", false);
    }
  }

  void _showDialog(String contextText, bool isuscces) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Bildiri"),
          content: new Text(contextText),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Kapat"),
              onPressed: () {
                if (isuscces) {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed("/login");
                }
              },
            ),
          ],
        );
      },
    );
  }

  void showDialogkVkk(String contextText, bool isuscces) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Bildiri"),
          content: new Text(contextText),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Kapat"),
              onPressed: () {
                if (isuscces) {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void showDialogKvkk() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            "MOBİL UYGULAMA KULLANICI SÖZLEŞMESİ ",
            style: TextStyle(fontWeight: FontWeight.bold, color: UIHelper.PEAR_PRIMARY_COLOR, fontSize: 12.0),
          ),
          content: new Padding(
            padding: const EdgeInsets.only(top: 1.0),
            child: SingleChildScrollView(
              child: Text(
                "Gizlilik Politikası ve Kullanım Koşulları\n\nBurada belirtilen gizlilik politikası " +
                    "ve kullanım koşulları; BİLDİRİREYİM BUNU'n Google Play Store ve IOS App Store'da yayınlanan" +
                    " bütün mobil uygulamaları için geçerlidir. Bu uygulamaları mobil cihazınıza yükleyerek, " +
                    "bu metinde yer alan gizlilik politikasını ve kullanım koşullarını kabul etmiş sayılırsınız." +
                    " Bu koşulları kabul etmiyorsanız bu uygulamaları mobil cihazınıza yüklemeyiniz \n\n" +
                    "Uygulamalarımızda, Girilen Veriler şifreli sunucularda sadece sizlerin görebileceği şekilde depolanır ve 3. şahıs yada kurumlar ile paylaşılmaz. " +
                    "Telefon Kullanım İzinleri,Uygulamımızdan bulunan kısayol arama işlemi için gerekli olan izinlerin tarafınızdan sağlanmış olması gerekir.Verilen bu izin sadece Uygulamadas kayıtlı olan müşterilerinizin kısayol aramlarında kullanılmaktadır ve müşterilerinize ait kişisel veriler sadece size özel veritabnlarında şifreli olarak saklanır." +
                    "\n\nİnternet Kullanım İzinleri,Uygulamımızdan Verilerin Şifreli sunuculara gönderilebilmesi için gerekli olan izindir ve kullanıcıların bunu tanımlaması gerekir. bu izinler telefonunuzdan isteğiniz dışında bir bilgiyi transfer etmek için kullanılmaz. Verilen internet erişim izni sadece uygulama içersinde dolduracağınız formlara ait veri ve fotoğraf transferi için kullanılmaktadır. " +
                    "\n\nKamera Kullanımı: Mobil Uygulamalarımızda kamera kullanımı sadece uygulama içersinden göndermek istediğiniz fotoğraflar için kullanılmaktadır. kullanıcı bilgisi dışında kullanımı söz konusu değildir. Mobil uygulamada çekilen fotoğraflar kullanıcıya ait şifreli ortamda saklanır ve sadece kendisinin ve bağlı olduğu kurumun erişimine açıktır. Fotoğraflar 3. şahıs yada kurumlar ile kullanıcı bilgisi dışında paylaşılmaz. " +
                    "\n\nUygulamalarımız, size ait herhangi bir kişisel bilgiyi toplamaz ve sizden bu yönde bir talepte bulunmaz. " +
                    "\n\nBİLDİRİREYİM BUNU, kaliteli ve yararlı uygulamalar yayınlamak için her zaman gereken özeni ve duyarlılığı gösterecektir. Buna rağmen, uygulamalarımızda yer alan içeriklerin beklentilerinizi karşılayacağı, size yararlı olacağı veya kesin doğru bilgiler içereceğine dair hiçbir taahhütte bulunmamaktayız. Uygulamaları olduğu gibi sunmaktayız. Bu sebeple, uygulamalarımızdan kaynaklı yaşanacak herhangi bir olumsuz durum için BİLDİRİREYİM BUNU'yu sorumlu tutamayacağınızı kabul etmektesiniz. " +
                    "\n\nBİLDİRİREYİM BUNU, bu uygulamaların güvenliği konusunda alınabilecek tüm önlemleri almak için gereken ölçüde çaba sarf eder ve Google Play Geliştirici Programı Politikaları sözleşmesi kapsamındaki yükümlülüklerini yerine getirir. Bununla birlikte; internet ve dijital ortamlar yeterli düzeyde güvenli alanlar değildir. Bu yüzden size yüzde yüz güvenli bir hizmet sunacağımız konusunda herhangi bir garantide bulunmamaktayız. " +
                    "\n\nUygulamalarımız sadece Google Play Store ve IOS App Store'da yer almaktadır. Bu uygulamaların bizim bilgimiz dışında başka bir android yada IOS mağazasında yer alması durumunda, buradan yapılacak yüklemelerden BİLDİRİREYİM BUNU sorumlu tutulamaz." +
                    "\n\nBu uygulamalarda, üçüncü taraflara ait reklamlar ve linkler yer alabilir. Bu üçüncü taraflara ait reklamların ve linklerin niteliğinden, içeriğinden, güvenliğinden veya bunlardan kaynaklı oluşabilecek zararlardan BİLDİRİREYİM BUNU'ni sorumlu tutamayacağınızı kabul etmektesiniz. Google tarafından yayınlanan reklamlara ilişkin ayarlarınızı nasıl düzenleyeceğinizi, reklam ayarları sayfasından öğrenebilirsiniz. " +
                    "\n\nBu uygulamalarda yer alan sesli, yazılı ve görsel öğelerden ve yazılımlardan oluşan bütün içeriğe ilişkin her türlü telif hakkı BİLDİRİREYİM BUNU’ya aittir. Herhangi bir uygulamamızı veya bu uygulamaların telif haklarıyla korunan içeriğini; kopyalama, çoğaltma, yeniden yayımlama, parçalarına ayırma, tekrar kamuya sunma vb. eylemlerde bulunmayacağınızı kabul etmektesiniz. " +
                    "\n\nBurada belirtilen koşullarla ilgili görüş ve önerilerinizi, info@komutteknolojisi.com mail adresinden bize iletebilirsiniz." +
                    "\n\nBİLDİRİREYİM BUNU; bu Gizlilik Politikası ve Kullanım Koşulları metninde değişiklik yapabilir. Yapılan değişiklikler anında yürürlüğe girecektir. Değişiklik yaptığımız tarihi, 'son güncelleme tarihi' olarak en alt kısımda belirtiriz." +
                    "\n\nSon güncelleme tarihi:" +
                    "\n\07.02.2021",
                style: TextStyle(color: Colors.black, fontSize: 10.0),
              ),
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Tamam"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
