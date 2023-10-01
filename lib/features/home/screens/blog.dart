import 'package:blog_explorer/model/blog_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/utils/app_colors.dart';
import '../controller/home_controller.dart';

class BlogDetailsPage extends StatelessWidget {
  BlogDetailsPage({
    super.key,
    required this.blog,
  });
  final BlogModel blog;
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final width = Get.width;
    final height = Get.height;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Blog Details',
          style: GoogleFonts.bayon(
            color: Colors.white,
            fontSize: width * 0.05,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.05,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Hero(
                  tag: 'like${blog.id!}',
                  child: IconButton(
                    iconSize: width * 0.15,
                    onPressed: () async {
                      controller.likedBlogs[blog.id!] =
                          !(controller.likedBlogs[blog.id!] ?? false);
                      await controller.prefs!
                          .setBool(blog.id!, controller.likedBlogs[blog.id!]);
                    },
                    icon: Obx(() {
                      return Icon(
                        Icons.favorite,
                        color: controller.likedBlogs[blog.id!] == false ||
                                controller.likedBlogs[blog.id!] == null
                            ? Colors.white
                            : Colors.red,
                      );
                    }),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.1,
            ),
            Hero(
              tag: 'image${blog.id!}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: blog.imageUrl!,
                  memCacheHeight: 200,
                  memCacheWidth: 200,
                  height: height * 0.25,
                  width: width,
                  fit: BoxFit.fill,
                  progressIndicatorBuilder: (context, url, progress) =>
                      const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Hero(
              tag: 'title${blog.id!}',
              child: SizedBox(
                width: width * 0.7,
                child: Text(
                  blog.title!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.bayon(
                    color: Colors.white,
                    fontSize: width * 0.05,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
