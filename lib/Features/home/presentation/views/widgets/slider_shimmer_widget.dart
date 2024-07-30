import 'package:car_rentting/Ui/shared_widget/image_or_svg.dart';
import 'package:car_rentting/core/functions/responsive.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SliderShimmer extends StatelessWidget {
  const SliderShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        height: 200,
        aspectRatio: 16 / 9,
        viewportFraction: 0.97,
        initialPage: 0,
        enableInfiniteScroll: false,
      ),
      items: [
        ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 1.0),
            decoration: const BoxDecoration(),
            child: ImageOrSvg(
              'assets/base/loading.gif',
              fit: BoxFit.fitWidth,
              isLocal: true,
              width: double.infinity,
            ),
          ),
        ),
      ],
    );
  }
}
