import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica_app/app/utils/colors.dart';
import 'package:medica_app/app/views/homeScreen/home_controller.dart';

class HomeCarousel extends StatelessWidget {
  const HomeCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        id: HomeController.sliderId,
        builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 16), // Adjusted spacing
              // Carousel Section
              Container(
                height: 160, // Fixed height to ensure no overflow
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 140,
                    viewportFraction: 0.9,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    onPageChanged: (index, reason) {
                      controller.changeCarouselIndex(index);
                    },
                  ),
                  items: controller.sliderList.map((item) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 2.0),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              // Text Section
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                      8.0), // Reduced padding
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        item.heading,
                                        style: const TextStyle(
                                          color: AppColors.white,
                                          fontSize: 18, // Reduced font size
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                          height: 4), // Reduced space
                                      Text(
                                        item.text,
                                        style: const TextStyle(
                                          color: AppColors.white,
                                          fontSize: 12,
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // Image Section
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(12),
                                      bottomRight: Radius.circular(12),
                                    ),
                                    child: Image.asset(
                                      item.imageUrl,
                                      height:
                                          100, // Reduced height for better fit
                                      width:
                                          100, // Reduced width for better fit
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),

              // Indicator Dots
              const SizedBox(height: 8), // Adjusted spacing
              GetBuilder<HomeController>(builder: (controller) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: controller.sliderList.asMap().entries.map((entry) {
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            controller.currentCarouselIndex.value == entry.key
                                ? const Color(0xFF0099CC)
                                : Colors.grey.withOpacity(0.3),
                      ),
                    );
                  }).toList(),
                );
              }),
            ],
          );
        });
  }
}
