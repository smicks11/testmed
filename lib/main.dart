import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medfest/Provider/freehealthcareprovider.dart';
import 'package:medfest/utils/colors.dart';
import 'routes/app_pages.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
  ));
  //Get.put(AppController());
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<FreeHealthCareProvider>(
          create: (_) => FreeHealthCareProvider())
    ],
    child: GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.SPLASHSCREEN,
      getPages: AppPages.routes,
      theme: ThemeData(
        fontFamily: 'Gilroy',
      ),
    ),
  ));
}
