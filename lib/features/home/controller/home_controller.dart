import 'dart:convert';

import 'package:blog_explorer/apirepository/product_repository.dart';
import 'package:blog_explorer/common/utils/app_constants.dart';
import 'package:blog_explorer/common/widgets/custom_widgets.dart';
import 'package:blog_explorer/model/blog_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../../../common/services/sqlite_sevice.dart';

class HomeController extends GetxController {
  RxList<BlogModel> blogs = <BlogModel>[].obs;
  Database? database;
  SharedPreferences? prefs;
  RxMap likedBlogs = {}.obs;

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      prefs = await SharedPreferences.getInstance();
      database = await SqliteService.initializeDB();
      final keys = prefs!.getKeys();
      for (String key in keys) {
        likedBlogs[key] = prefs!.get(key) ?? false;
      }
      Get.showOverlay(
        asyncFunction: () => getBlogs(),
        loadingWidget: const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
    });
    super.onInit();
  }

  Future<void> getBlogs() async {
    try {
      await callGetMethod(AppConstants.getBlogs).then((apiResponse) async {
        if (apiResponse.responseString != null) {
          Map valueMap = json.decode(apiResponse.responseString!);
          if (valueMap["success"] == null) {
            List map = await valueMap['blogs'];
            // usersData.addAll(data.map((data) => UsersModel.fromMap(data)));
            for (int i = 0; i < map.length; i++) {
              blogs.add(BlogModel.fromJson(map[i]));
              database!.insert(
                'blogs',
                map[i],
                conflictAlgorithm: ConflictAlgorithm.replace,
              );
            }
          } else {
            try {
              blogs.value = await getBlogsFromDB();
            } catch (e) {
              Get.showSnackbar(
                CustomWidgets.customSnackBar(
                  content: 'An error occurred: $e',
                ),
              );
            }
          }
        } else {
          Get.showSnackbar(
            CustomWidgets.customSnackBar(
              content: 'An error occurred',
            ),
          );
        }
      });
    } catch (e) {
      Get.showSnackbar(
        CustomWidgets.customSnackBar(
          content: 'An error occurred: $e',
        ),
      );
    }
  }

  Future<List<BlogModel>> getBlogsFromDB() async {
    final db = await SqliteService.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('blogs');
    return queryResult.map((e) => BlogModel.fromJson(e)).toList();
  }
}
