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

  /// File path: assets/icons/add_home.svg
  SvgGenImage get addHome => const SvgGenImage('assets/icons/add_home.svg');

  /// File path: assets/icons/cart.svg
  SvgGenImage get cart => const SvgGenImage('assets/icons/cart.svg');

  /// File path: assets/icons/home.svg
  SvgGenImage get home => const SvgGenImage('assets/icons/home.svg');

  /// File path: assets/icons/profile.svg
  SvgGenImage get profile => const SvgGenImage('assets/icons/profile.svg');

  /// File path: assets/icons/upload.svg
  SvgGenImage get upload => const SvgGenImage('assets/icons/upload.svg');

  /// List of all assets
  List<SvgGenImage> get values => [addHome, cart, home, profile, upload];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.png');

  /// File path: assets/images/logo_png.png
  AssetGenImage get logoPng => const AssetGenImage('assets/images/logo_png.png');

  /// File path: assets/images/placeholder.jpg
  AssetGenImage get placeholder => const AssetGenImage('assets/images/placeholder.jpg');

  /// File path: assets/images/robot.png
  AssetGenImage get robot => const AssetGenImage('assets/images/robot.png');

  /// File path: assets/images/robot_result.png
  AssetGenImage get robotResult => const AssetGenImage('assets/images/robot_result.png');

  /// List of all assets
  List<AssetGenImage> get values => [logo, logoPng, placeholder, robot, robotResult];
}

class $AssetsLottieGen {
  const $AssetsLottieGen();

  /// File path: assets/lottie/book.json
  String get book => 'assets/lottie/book.json';

  /// File path: assets/lottie/circle_star.json
  String get circleStar => 'assets/lottie/circle_star.json';

  /// File path: assets/lottie/clock.json
  String get clock => 'assets/lottie/clock.json';

  /// File path: assets/lottie/correct.json
  String get correct => 'assets/lottie/correct.json';

  /// File path: assets/lottie/correct2.json
  String get correct2 => 'assets/lottie/correct2.json';

  /// File path: assets/lottie/diamond.json
  String get diamond => 'assets/lottie/diamond.json';

  /// File path: assets/lottie/error.json
  String get error => 'assets/lottie/error.json';

  /// File path: assets/lottie/error2.json
  String get error2 => 'assets/lottie/error2.json';

  /// File path: assets/lottie/hourglass.json
  String get hourglass => 'assets/lottie/hourglass.json';

  /// File path: assets/lottie/incorrect.json
  String get incorrect => 'assets/lottie/incorrect.json';

  /// File path: assets/lottie/laptop.json
  String get laptop => 'assets/lottie/laptop.json';

  /// File path: assets/lottie/linkcopy.json
  String get linkcopy => 'assets/lottie/linkcopy.json';

  /// File path: assets/lottie/loading.json
  String get loading => 'assets/lottie/loading.json';

  /// File path: assets/lottie/loading2.json
  String get loading2 => 'assets/lottie/loading2.json';

  /// File path: assets/lottie/money.json
  String get money => 'assets/lottie/money.json';

  /// File path: assets/lottie/phone.json
  String get phone => 'assets/lottie/phone.json';

  /// File path: assets/lottie/share.json
  String get share => 'assets/lottie/share.json';

  /// File path: assets/lottie/timer.json
  String get timer => 'assets/lottie/timer.json';

  /// List of all assets
  List<String> get values => [
    book,
    circleStar,
    clock,
    correct,
    correct2,
    diamond,
    error,
    error2,
    hourglass,
    incorrect,
    laptop,
    linkcopy,
    loading,
    loading2,
    money,
    phone,
    share,
    timer,
  ];
}

class $AssetsVectorsGen {
  const $AssetsVectorsGen();

  /// File path: assets/vectors/add_home.vec
  SvgGenImage get addHome => const SvgGenImage.vec('assets/vectors/add_home.vec');

  /// File path: assets/vectors/cart.vec
  SvgGenImage get cart => const SvgGenImage.vec('assets/vectors/cart.vec');

  /// File path: assets/vectors/home.vec
  SvgGenImage get home => const SvgGenImage.vec('assets/vectors/home.vec');

  /// File path: assets/vectors/profile.vec
  SvgGenImage get profile => const SvgGenImage.vec('assets/vectors/profile.vec');

  /// File path: assets/vectors/upload.vec
  SvgGenImage get upload => const SvgGenImage.vec('assets/vectors/upload.vec');

  /// List of all assets
  List<SvgGenImage> get values => [addHome, cart, home, profile, upload];
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
