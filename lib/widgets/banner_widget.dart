import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecom/controllers/banners_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final CarouselController carouselController = CarouselController();
  final BannersController _bannersController = Get.put(BannersController());
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: Get.height * 0.3,
      // width: Get.width,
      // color: Colors.amber,
      child: Obx(() {
        return CarouselSlider(
          items: _bannersController.bannersUrls
              .map(
                (imageurls) => ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: CachedNetworkImage(
                    imageUrl: imageurls,
                    fit: BoxFit.cover,
                    width: Get.width,
                    placeholder: (context, url) => const ColoredBox(
                      color: Colors.white,
                      child: Center(
                        child: CupertinoActivityIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              )
              .toList(),
          options: CarouselOptions(
              scrollDirection: Axis.horizontal,
              autoPlay: true,
              aspectRatio: 2.5,
              viewportFraction: 1),
        );
      }),
    );
  }
}
