import 'package:blog_explorer/features/home/screens/blog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/utils/app_colors.dart';
import '../controller/home_controller.dart';

class FavouriteBlogsPage extends StatefulWidget {
  const FavouriteBlogsPage({super.key});

  @override
  State<FavouriteBlogsPage> createState() => _FavouriteBlogsPageState();
}

class _FavouriteBlogsPageState extends State<FavouriteBlogsPage> {
  final controller = Get.put(HomeController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Get.showOverlay(
        asyncFunction: () => controller.getFavouriteBlogsFromDB(),
        loadingWidget: const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = Get.width;
    final height = Get.height;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Favourite Blogs',
          style: GoogleFonts.bayon(
            color: Colors.white,
            fontSize: width * 0.05,
          ),
        ),
      ),
      body: Obx(() {
        return SizedBox(
          height: height,
          child: controller.favouriteBlogs.isNotEmpty
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: controller.favouriteBlogs.map((blog) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.05,
                          vertical: height * 0.02,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.to(
                                      BlogDetailsPage(
                                        blog: blog,
                                      ),
                                    );
                                  },
                                  child: Hero(
                                    tag: 'image${blog?.id!}',
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                        imageUrl: blog!.imageUrl!,
                                        memCacheHeight: 182,
                                        memCacheWidth: 137,
                                        height: height * 0.25,
                                        width: width,
                                        fit: BoxFit.fill,
                                        progressIndicatorBuilder:
                                            (context, url, progress) =>
                                                const Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Hero(
                                      tag: 'like${blog.id!}',
                                      child: IconButton(
                                        onPressed: () async {
                                          controller.likedBlogs[blog.id!] =
                                              !(controller
                                                      .likedBlogs[blog.id!] ??
                                                  false);
                                          await controller.prefs!.setBool(
                                              blog.id!,
                                              controller.likedBlogs[blog.id!]);
                                        },
                                        icon: Icon(
                                          Icons.favorite,
                                          color:
                                              controller.likedBlogs[blog.id!] ==
                                                          false ||
                                                      controller.likedBlogs[
                                                              blog.id!] ==
                                                          null
                                                  ? Colors.white
                                                  : Colors.red,
                                          size: width * 0.08,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.015,
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
                      );
                    }).toList(),
                  ),
                )
              : Center(
                  child: SizedBox(
                    width: width * 0.7,
                    child: Text(
                      'There is no liked Blogs',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.bayon(
                        color: Colors.white,
                        fontSize: width * 0.08,
                      ),
                    ),
                  ),
                ),
        );
      }),
    );
  }
}
