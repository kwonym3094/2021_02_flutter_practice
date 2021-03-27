import 'package:flutter/material.dart';
import 'package:flutter_example/src/pages/controller/dependency_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_example/src/pages/dependencies/get_put_revival.dart';

class DepManagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              child: Text("Get.put"),
              onPressed: () {
                Get.to(() => GetPutRevival(), binding: BindingsBuilder(() {
                  Get.put(DependencyController());
                }));
              },
            ),
            RaisedButton(
                child: Text("Get.lazyPut"),
                onPressed: () {
                  Get.to(() => GetPutRevival(), binding: BindingsBuilder(() {
                    Get.lazyPut<DependencyController>(
                        () => DependencyController());
                  }));
                }),
            RaisedButton(
              child: Text("Get.putAsync"),
            ),
            RaisedButton(
              child: Text("Get.create"),
            ),
          ],
        ),
      ),
    );
  }
}
