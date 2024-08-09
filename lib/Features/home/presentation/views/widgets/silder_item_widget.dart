import 'package:car_rentting/Features/categories/presentation/view/all_categories.dart';
import 'package:car_rentting/Features/home/domain/entities/ad_entity.dart';
import 'package:car_rentting/Features/services/presentation/views/servics_view.dart';
import 'package:car_rentting/Ui/shared_widget/image_or_svg.dart';
import 'package:car_rentting/core/functions/responsive.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class SliderItem extends StatelessWidget {
  const SliderItem(
    this.item, {
    super.key,
  });

  final AdEntity item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        switch (item.adType) {
          case AdType.none:
            break;
          case AdType.category:
            Get.to(() => AllCategories(
            null,
                  id: int.parse(item.navTo),
                ));
            break;
          case AdType.service:
            Get.to(() => ServiceScreen(
                  int.parse(item.navTo),
                  isFromOrder: false,
                  isProduct: false,
                ));
            break;
          case AdType.link:
            launchUrl(Uri.parse(item.navTo));
            break;
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(),
          child: ImageOrSvg(
            item.photo,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

class SliderShimmerItem extends StatelessWidget {
  const SliderShimmerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
