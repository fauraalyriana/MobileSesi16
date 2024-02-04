import 'package:dio/dio.dart';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'repository.dart';
import 'dart:convert';
import 'dart:io';

class NewsRepository extends Repository {
  final Dio _dio = Dio();

  Future addNews(
      {required String title,
      required String desc,
      required String date,
      required File image}) async {
    try {
      FormData formData = FormData.fromMap({
        'judul': title,
        'desc': desc,
        'date': date,
        'gambar':
            await MultipartFile.fromFile(image.path, filename: 'image.jpg')
      });

      Response response = await _dio.post(
          "https://tugas9faura.000webhostapp.com/pemMobile/addNews.php",
          data: formData);
      log("Response add data :" + response.data);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception("Failed to add news");
      }
    } catch (error) {
      log("Error $error");
    }
  }

  Future getlistNews(String keyword) async {
    FormData formData = FormData.fromMap({
      'key': keyword,
    });
    try {
      log("AMBIL LIST");
      var response = await _dio.post(
          "https://tugas9faura.000webhostapp.com/pemMobile/listNews.php",
          data: formData);
      log("list $response");

      if (response.statusCode == 200) {
        List newsList = response.data;
        return newsList;
      } else {
        log("Error" + response.statusCode.toString());
        return [];
      }
    } catch (error) {
      log("Error $error");
      return [];
    }
  }

  Future selectNews(String newsId) async {
    FormData formData = FormData.fromMap({
      'idnews': newsId,
    });
    try {
      log("SELECT NEWS");
      var response = await _dio.post(
          "https://tugas9faura.000webhostapp.com/pemMobile/selectdata.php",
          data: formData);
      log("select data $response");

      if (response.statusCode == 200) {
        List newsList = response.data;
        return newsList;
      } else {
        log("Error" + response.statusCode.toString());
        return [];
      }
    } catch (error) {
      log("Error $error");
      return [];
    }
  }

  Future deleteNews(String newsId) async {
    FormData formData = FormData.fromMap({
      'idnews': newsId,
    });
    try {
      log("DELETE NEWS");
      var response = await _dio.post(
          "https://tugas9faura.000webhostapp.com/pemMobile/deleteNews.php",
          data: formData);
      log("delete data $response");

      if (response.statusCode == 200) {
        List newsList = response.data;
        return newsList;
      } else {
        log("Error" + response.statusCode.toString());
        return [];
      }
    } catch (error) {
      log("Error $error");
      return [];
    }
  }
}
