import 'package:car_rentting/Features/home/presentation/manager/home_providers.dart';
import 'package:car_rentting/Features/home/presentation/views/widgets/silder_item_widget.dart';
import 'package:car_rentting/core/functions/responsive.dart';
import 'package:car_rentting/core/functions/riverpod.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/utils/app_fonts.dart';

class HomeSliderWidget extends ConsumerWidget {
  const HomeSliderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final fetchAds = ref.watch(fetchAdsProvider);
    return fetchAds.customWhen(
        loading: () {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * .4,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              ),
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  height: 200,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                ),
                items: const [
                  SliderShimmerItem(),
                  SliderShimmerItem(),
                  SliderShimmerItem(),
                ],
              ),
            ],
          );
        },
        data: (dsa) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text(
              //     "Some service's sponsors".tr,
              //     style: AppFontStyle.black_18
              //         .copyWith(fontWeight: FontWeight.bold),
              //   ),
              // ),
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  height: 200,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                ),
                items: dsa.map((e) => SliderItem(e)).toList(),
              ),
            ],
          );
        },
        refreshable: fetchAdsProvider.future,
        ref: ref);
  }
}
