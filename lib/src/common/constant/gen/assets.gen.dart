// dart format width=120

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $ConfigGen {
  const $ConfigGen();

  /// File path: config/development.json
  String get development => 'config/development.json';

  /// File path: config/production.json
  String get production => 'config/production.json';

  /// File path: config/staging.json
  String get staging => 'config/staging.json';

  /// List of all assets
  List<String> get values => [development, production, staging];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/cart.svg
  SvgGenImage get cart => const SvgGenImage('assets/icons/cart.svg');

  /// File path: assets/icons/home.svg
  SvgGenImage get home => const SvgGenImage('assets/icons/home.svg');

  /// File path: assets/icons/profile.svg
  SvgGenImage get profile => const SvgGenImage('assets/icons/profile.svg');

  /// List of all assets
  List<SvgGenImage> get values => [cart, home, profile];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.png');

  /// File path: assets/images/logo_png.png
  AssetGenImage get logoPng => const AssetGenImage('assets/images/logo_png.png');

  /// File path: assets/images/placeholder.jpg
  AssetGenImage get placeholder => const AssetGenImage('assets/images/placeholder.jpg');

  /// List of all assets
  List<AssetGenImage> get values => [logo, logoPng, placeholder];
}

class $AssetsLottieGen {
  const $AssetsLottieGen();

  /// File path: assets/lottie/book.lottie
  String get book => 'assets/lottie/book.lottie';

  /// File path: assets/lottie/circle_star copy.lottie
  String get circleStarCopy => 'assets/lottie/circle_star copy.lottie';

  /// File path: assets/lottie/circle_star.lottie
  String get circleStar => 'assets/lottie/circle_star.lottie';

  /// File path: assets/lottie/diamond.lottie
  String get diamond => 'assets/lottie/diamond.lottie';

  /// File path: assets/lottie/error.lottie
  String get error => 'assets/lottie/error.lottie';

  /// File path: assets/lottie/error_2.lottie
  String get error2 => 'assets/lottie/error_2.lottie';

  /// File path: assets/lottie/iPhone.lottie
  String get iPhone => 'assets/lottie/iPhone.lottie';

  /// File path: assets/lottie/laptop.lottie
  String get laptop => 'assets/lottie/laptop.lottie';

  /// File path: assets/lottie/money.json
  String get moneyJson => 'assets/lottie/money.json';

  /// File path: assets/lottie/money.lottie
  String get moneyLottie => 'assets/lottie/money.lottie';

  /// File path: assets/lottie/timer.lottie
  String get timer => 'assets/lottie/timer.lottie';

  /// List of all assets
  List<String> get values => [
    book,
    circleStarCopy,
    circleStar,
    diamond,
    error,
    error2,
    iPhone,
    laptop,
    moneyJson,
    moneyLottie,
    timer,
  ];
}

class $AssetsVectorsGen {
  const $AssetsVectorsGen();

  /// File path: assets/vectors/cart.vec
  SvgGenImage get cart => const SvgGenImage.vec('assets/vectors/cart.vec');

  /// File path: assets/vectors/home.vec
  SvgGenImage get home => const SvgGenImage.vec('assets/vectors/home.vec');

  /// File path: assets/vectors/profile.vec
  SvgGenImage get profile => const SvgGenImage.vec('assets/vectors/profile.vec');

  /// List of all assets
  List<SvgGenImage> get values => [cart, home, profile];
}

class Assets {
  const Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLottieGen lottie = $AssetsLottieGen();
  static const $AssetsVectorsGen vectors = $AssetsVectorsGen();
  static const $ConfigGen config = $ConfigGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}, this.animation});

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

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
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
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

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({required this.isAnimation, required this.duration, required this.frames});

  final bool isAnimation;
  final Duration duration;
  final int frames;
}

class SvgGenImage {
  const SvgGenImage(this._assetName, {this.size, this.flavors = const {}}) : _isVecFormat = false;

  const SvgGenImage.vec(this._assetName, {this.size, this.flavors = const {}}) : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    _svg.ColorMapper? colorMapper,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(_assetName, assetBundle: bundle, packageName: package);
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
        colorMapper: colorMapper,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ?? (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
