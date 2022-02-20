import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:led_controller/services/esp_connection_service.dart';
import '/bindings/bindings.dart';
import '/routes/app_pages.dart';
import '/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String address = "192.168.1.102";
  int port = 4023;
  await ESPConnectionService.bindUpd(address, port);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Led Controller',
      theme: ThemeData(primarySwatch: Colors.blue),
      getPages: AppPages.pages,
      initialBinding: HomeBinding(),
      initialRoute: AppRoutes.connection,
    );
  }
}
