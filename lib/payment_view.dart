import 'dart:async';

import 'package:car_rentting/core/functions/responsive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'Ui/shared_widget/image_or_svg.dart';
import 'core/utils/api_service.dart';
import 'main.dart';

class PaymentView extends StatefulWidget {
  const PaymentView(this.url, {super.key});
  final String url;

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  final RxInt progress = RxInt(0);

  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    Get.put(Indicator());
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setUserAgent(
          "Mozilla/5.0 (Linux; Android 10) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.5563.115 Mobile Safari/537.36")
      ..setNavigationDelegate(
        NavigationDelegate(onProgress: (int ss) {
          progress.value = ss;
        }, onPageStarted: (String url) {
          final urlLowerCase = url.toLowerCase();
          Get.find<Indicator>().setBusy();
          logger.d(url);
          if (urlLowerCase.contains("/success")) {
            Get.back(result: true);
          } else if (urlLowerCase.contains("/fail")) {
            Get.back(result: false);
          }
        }, onPageFinished: (String url) {
          Get.find<Indicator>().setIdle();

          final urlLowerCase = url.toLowerCase();
          if (urlLowerCase.contains("/success")) {
            Get.back(result: true);
          } else if (urlLowerCase.contains("/fail")) {
            Get.back(result: false);
          }
        }, onWebResourceError: (WebResourceError error) {
          Get.find<Indicator>().setIdle();
          Get.back(result: false);
        }, onNavigationRequest: (_) {
          return NavigationDecision.navigate;
        }),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _exitPayment(),
      child: Scaffold(
        body: WrapWithLoading(
          hideChild: true,
          progress: progress,
          child: WebViewWidget(
            gestureRecognizers: {
              Factory<VerticalDragGestureRecognizer>(
                () => VerticalDragGestureRecognizer(),
              ),
            },
            controller: _controller,
          ),
        ),
      ),
    );
  }

  Future<bool> _exitPayment() async {
    return !(await UIHelper.showSelectableDialog(
          'cancelpayment'.tr,
          "yescancel".tr,
          "continuepay".tr,
        ) ??
        true);
  }
}

class WrapWithLoading extends StatelessWidget {
  const WrapWithLoading({
    super.key,
    required this.child,
    this.hideChild = false,
    this.progress,
  });

  final RxInt? progress;
  final Widget child;
  final bool hideChild;

  @override
  Widget build(BuildContext context) {
    responsiveInit(context);
    return Obx(
      () => LoadingOverlay(
        color: Colors.white,
        progressIndicator: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LoadingWidget(),
            if (progress != null && progress?.value is int)
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
                child: LinearProgressIndicator(
                  value: progress!.value.toDouble() / 100,
                ),
              ),
          ],
        ),
        opacity:
            hideChild && Get.find<Indicator>().loading.value == true ? 1 : 0,
        isLoading: Get.find<Indicator>().loading.value,
        child: child,
      ),
    );
  }
}

class Indicator extends GetxService {
  final RxBool _loading = false.obs;
  static const printLog = false;
  RxBool get loading => _loading;

  void setBusy() {
    if (printLog) logger.d('set indicator busy');
    _loading.value = true;
  }

  void setIdle() {
    if (printLog) logger.d('set indicator idle');
    _loading.value = false;
  }
}

/// Our custom fork of https://pub.dev/packages/modal_progress_hud adding a fading effect
///
/// wrapper around any widget that makes an async call to show a modal progress
/// indicator while the async call is in progress.
///
/// The progress indicator can be turned on or off using [isLoading]
///
/// The progress indicator defaults to a [CircularProgressIndicator] but can be
/// any kind of widget
///
/// The color of the modal barrier can be set using [color]
///
/// The opacity of the modal barrier can be set using [opacity]
///
/// HUD=Heads Up Display
///
class LoadingOverlay extends StatefulWidget {
  final bool isLoading;
  final double opacity;
  final Color? color;
  final Widget progressIndicator;
  final Widget child;

  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    this.opacity = 0.5,
    this.progressIndicator = const CircularProgressIndicator(),
    this.color,
  });

  @override
  _LoadingOverlayState createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<LoadingOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool? _overlayVisible;

  _LoadingOverlayState();

  @override
  void initState() {
    super.initState();
    _overlayVisible = false;
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _animation.addStatusListener((status) {
      // ignore: unnecessary_statements
      status == AnimationStatus.forward
          ? setState(() {
              _overlayVisible = true;
            })
          : null;
      // ignore: unnecessary_statements
      status == AnimationStatus.dismissed
          ? setState(() {
              _overlayVisible = false;
            })
          : null;
    });
    if (widget.isLoading) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(LoadingOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.isLoading && widget.isLoading) {
      _controller.forward();
    }

    if (oldWidget.isLoading && !widget.isLoading) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var widgets = <Widget>[];
    widgets.add(widget.child);

    if (_overlayVisible == true) {
      final modal = FadeTransition(
        opacity: _animation,
        child: Stack(
          children: <Widget>[
            Opacity(
              opacity: widget.opacity,
              child: ModalBarrier(
                dismissible: false,
                color: widget.color ?? Theme.of(context).colorScheme.background,
              ),
            ),
            Center(child: widget.progressIndicator),
          ],
        ),
      );
      widgets.add(modal);
    }

    return Stack(children: widgets);
  }
}
