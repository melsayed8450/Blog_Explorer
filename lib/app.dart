import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'common/routes/app_pages.dart';
import 'common/routes/app_routes.dart';

class BlogExplorer extends StatelessWidget {
  const BlogExplorer({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.routes,
      initialRoute: AppPages.home,
    );
  }
}
