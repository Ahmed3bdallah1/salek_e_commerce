import 'package:car_rentting/core/utils/colors.dart';
import 'package:car_rentting/core/utils/const.dart';
import 'package:extended_image/extended_image.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../core/functions/responsive.dart';

class ImageOrSvg extends StatefulWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color;
  final bool magnifier;
  final bool isLocal;
  final bool isLoading;

  ImageOrSvg(
    this.url, {
    Key? key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.magnifier = false,
    this.color,
    this.isLoading = false,
    this.isLocal = false,
  }) : super(key: ValueKey(url));

  @override
  State<ImageOrSvg> createState() => _ImageOrSvgState();
}

class _ImageOrSvgState extends State<ImageOrSvg>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    responsiveInit(context);
    if (widget.isLoading) {
      return Container(
        width: widget.width,
        height: widget.height,
        decoration: const BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        ),
        child: const Center(child: LoadingWidget()),
      );
    }
    final fullPath = widget.isLocal
        ? widget.url
        : widget.url.startsWith("http")
            ? widget.url
            : "$uploadPath${widget.url}";
    return widget.isLocal
        ? ExtendedImage.asset(
            fullPath,
            key: widget.key,
            width: widget.width,
            color: widget.color,
            height: widget.height,
            fit: widget.fit,
            opacity: _controller,
            enableLoadState: true,
            loadStateChanged: _handleLoadStateChange,
          )
        : ExtendedImage.network(
            fullPath,
            key: widget.key,
            width: widget.width,
            color: widget.color,
            height: widget.height,
            fit: widget.fit,
            cache: true,
            opacity: _controller,
            handleLoadingProgress: true,
            enableLoadState: true,
            cacheMaxAge: const Duration(days: 7),
            loadStateChanged: _handleLoadStateChange,
          );
  }

  Widget _handleLoadStateChange(ExtendedImageState ff) {
    switch (ff.extendedImageLoadState) {
      case LoadState.loading:
        _controller.reset();
        return Image.asset(
          "assets/base/loading.gif",
          fit: BoxFit.fill,
        );
      case LoadState.failed:
        _controller.forward();
        return FadeTransition(
          opacity: _controller,
          child: InkWell(
            onTap: () {
              ff.reLoadImage();
            },
            child: const Icon(
              Icons.error,
              color: Colors.red,
            ),
          ),
        );
      case LoadState.completed:
        _controller.forward();
        return FadeTransition(
          opacity: _controller,
          child: InkWell(
            child: ExtendedRawImage(
              image: ff.extendedImageInfo?.image,
              width: widget.width,
              color: widget.color,
              height: widget.height,
              fit: widget.fit,
            ),
          ),
        );
    }
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget(
      {super.key, this.color = AppColors.primaryColorSALEK2, this.size = 30});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    responsiveInit(context);
    return Center(
      child: LoadingAnimationWidget.inkDrop(
        color: color,
        size: size,
      ),
    );
  }
}
