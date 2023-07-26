import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_list_scroll/src/presentation/loading_controller/loading_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LoadingController loadingController = Get.put(LoadingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('API Test'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => ListView.separated(
                controller: loadingController.scrollController,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "Name : ${loadingController.itemList[index].name}"),
                            Text(
                                'Email : ${loadingController.itemList[index].email}'),
                          ],
                        ),
                        subtitle: Text(
                            'Body : ${loadingController.itemList[index].body}'),
                        contentPadding: const EdgeInsets.only(
                            top: 15, bottom: 15, left: 25, right: 25),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                width: 2)),
                      ),
                      (index == loadingController.itemList.length - 1)
                          ? Obx(
                           ()=> Padding(
                                padding: EdgeInsets.all(8),
                                child: (loadingController
                                            .itemLoadingFinished.value ==
                                        false)
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : Text("End of list"),
                              ),
                          )
                          : SizedBox()
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemCount: loadingController.itemList.length),
          ),
        ));
  }
}
