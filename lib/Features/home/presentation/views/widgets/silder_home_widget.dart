import 'package:car_rentting/Features/home/presentation/manager/home_providers.dart';
import 'package:car_rentting/Features/home/presentation/views/widgets/silder_item_widget.dart';
import 'package:car_rentting/core/functions/responsive.dart';
import 'package:car_rentting/core/functions/riverpod.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeSliderWidget extends ConsumerWidget {
  const HomeSliderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final fetchAds = ref.watch(fetchAdsProvider);
    return fetchAds.customWhen(
        loading: () {
          return const SliderShimmerItem();
        },
        data: (dsa) {
          return CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              height: 200,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: false,
            ),
            items: dsa.map((e) => SliderItem(e)).toList(),
          );
        },
        refreshable: fetchAdsProvider.future,
        ref: ref);
  }
}
