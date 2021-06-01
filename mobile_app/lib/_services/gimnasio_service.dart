import 'package:mobile_app/_models/gimnasio.dart';
import '_base.dart';
import 'error_service.dart';

abstract class GimnasioService {
  static Future<List<GimnasioList>?> getList() async {
    List<GimnasioList> list;

    var response = await Base.dio.get('/gimnasios')
        .catchError((e) => ErrorService.dio(e));

    if (response.statusCode != 200)
      return null;

    list = (response.data as List<dynamic>)
        .map((e) => GimnasioList.fromJson(e))
        .toList();

    return list;
  }

  static Future<GimnasioDetails> getDetails(String id) async {
    var response = await Base.dio.get('/gimnasios/$id')
        .catchError((e) => ErrorService.dio(e));

    return GimnasioDetails.fromJson(response.data);
  }
}
