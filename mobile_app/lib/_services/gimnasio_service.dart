import 'package:mobile_app/_models/gimnasio.dart';
import '_base.dart';

abstract class GimnasioService {
  static Future<List<GimnasioList>> getList() async {
    List<GimnasioList> list;

    var dio = Base.dio;

    var response = await dio.get('/gimnasios');

    list = (response.data as List<dynamic>)
        .map((e) => GimnasioList.fromJson(e))
        .toList();

    return list;
  }
}
