import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../domain/models/remote_model_class/remote_model_class.dart';

class ApiFunctions {
  Future<List<RemoteModelClass>> getData() async {
    try {
      final response = await Dio()
          .get('https://jsonplaceholder.typicode.com/posts/1/comments');
      if (response.statusCode == 200) {
        List<RemoteModelClass> result = (response.data as List<dynamic>)
            .map((e) => RemoteModelClass.fromJson(e as Map<String, dynamic>))
            .toList();
        for (int i = 0; i < 2; i++) {
          result.addAll(List.from(result));
        }
        
        return result;
      } else {
        throw Exception();
      }
    } catch (e) {
      Get.snackbar('something went wrong', e.toString());
      log(e.toString());
      throw Exception();
    }
  }
}
