/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsBaseGen {
  const $AssetsBaseGen();

  /// File path: assets/base/eye-crossed.svg
  String get eyeCrossed => 'assets/base/eye-crossed.svg';

  /// File path: assets/base/eye.svg
  String get eye => 'assets/base/eye.svg';

  /// File path: assets/base/gift.svg
  String get gift => 'assets/base/gift.svg';

  /// File path: assets/base/lgo.png
  AssetGenImage get lgo => const AssetGenImage('assets/base/lgo.png');

  /// File path: assets/base/loading.gif
  AssetGenImage get loading => const AssetGenImage('assets/base/loading.gif');

  /// File path: assets/base/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/base/logo.png');

  /// File path: assets/base/logo2.png
  AssetGenImage get logo2 => const AssetGenImage('assets/base/logo2.png');

  /// File path: assets/base/logo3.png
  AssetGenImage get logo3 => const AssetGenImage('assets/base/logo3.png');

  /// File path: assets/base/logo4.png
  AssetGenImage get logo4 => const AssetGenImage('assets/base/logo4.png');

  /// File path: assets/base/no_wifi.json
  String get noWifi => 'assets/base/no_wifi.json';

  /// File path: assets/base/search.svg
  String get search => 'assets/base/search.svg';

  /// List of all assets
  List<dynamic> get values => [
        eyeCrossed,
        eye,
        gift,
        lgo,
        loading,
        logo,
        logo2,
        logo3,
        logo4,
        noWifi,
        search
      ];
}

class $AssetsSocialMediaGen {
  const $AssetsSocialMediaGen();

  /// File path: assets/social_media/facebook.png
  AssetGenImage get facebook =>
      const AssetGenImage('assets/social_media/facebook.png');

  /// File path: assets/social_media/gmail.png
  AssetGenImage get gmail =>
      const AssetGenImage('assets/social_media/gmail.png');

  /// File path: assets/social_media/instagram.png
  AssetGenImage get instagram =>
      const AssetGenImage('assets/social_media/instagram.png');

  /// File path: assets/social_media/twitter.png
  AssetGenImage get twitter =>
      const AssetGenImage('assets/social_media/twitter.png');

  /// File path: assets/social_media/youtube.png
  AssetGenImage get youtube =>
      const AssetGenImage('assets/social_media/youtube.png');

  /// List of all assets
  List<AssetGenImage> get values =>
      [facebook, gmail, instagram, twitter, youtube];
}

class Assets {
  Assets._();

  static const $AssetsBaseGen base = $AssetsBaseGen();
  static const $AssetsSocialMediaGen socialMedia = $AssetsSocialMediaGen();
  static const String a15 = 'assets/عقارك-15.svg';

  /// List of all assets
  static List<String> get values => [a15];
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size = null});

  final String _assetName;

  final Size? size;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
