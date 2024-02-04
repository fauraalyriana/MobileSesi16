import 'package:dio/dio.dart';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'repository.dart';
import 'dart:convert';

class LoginRepository extends Repository {
  Future login({required String username, required String password}) async {
    final Dio _dio = Dio();
    Map fdataMap = {'user': username, 'pwd': password};
    FormData formData = FormData();
    formData.fields
        .addAll(fdataMap.entries.map((e) => MapEntry(e.key, e.value)));

    final response = await _dio.post(
        "https://tugas9faura.000webhostapp.com/pemMobile/login.php",
        data: formData);
    log("hasil res $response");
    Map repoResponse = {'status': false, "data": Null};

    if (response.statusCode == 200) {
      log("Masuk");
      final Map<String, dynamic> data = response.data;
      if (data['status'] == 'success') {
        repoResponse['status'] = true;
        repoResponse['data'] = data;
        final SharedPreferences preferences =
            await SharedPreferences.getInstance();
        preferences.setString('session', data['session_token']);
      } else {
        repoResponse['data'] = data;
      }
    }

    return repoResponse;
  }

  Future logout() async {
    final Dio _dio = Dio();
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String session = preferences.getString('session') ?? "";
    Map fdataMap = {'session': session};
    FormData formData = FormData();
    formData.fields
        .addAll(fdataMap.entries.map((e) => MapEntry(e.key, e.value)));

    final response = await _dio.post(
        "https://tugas9faura.000webhostapp.com/pemMobile/logout.php",
        data: formData);
    preferences.remove('session');
  }
}
