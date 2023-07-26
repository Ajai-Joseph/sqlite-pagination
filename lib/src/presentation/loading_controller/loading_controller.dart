
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/datasources/local/database_functions.dart';
import '../../domain/models/local_model_class/local_model_class.dart';

class LoadingController extends GetxController {
  RxList<LocalModelClass> itemList = <LocalModelClass>[].obs;

  RxBool itemLoadingFinished = false.obs;
  int count = 0;
  ScrollController scrollController = ScrollController();

  Future loadData() async {
    List<LocalModelClass> tempItemList =
        await DataBaseFunctions().getLimitedData(count);
    if (tempItemList.isNotEmpty) {
      itemList.addAll(tempItemList);
    } else {
      itemLoadingFinished.value = true;
    }
  }

  @override
  void onInit() {
    super.onInit();

    loadData();
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (itemLoadingFinished.value == false) {
          count++;
          await loadData();
        }
      }
    });
  }
}
