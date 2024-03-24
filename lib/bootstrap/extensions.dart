import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '/bootstrap/helpers.dart';
import '/resources/themes/styles/color_styles.dart';
import 'package:nylo_framework/nylo_framework.dart';

/// [Text] Extensions
extension NyText on Text {
  Text setColor(
      BuildContext context, Color Function(ColorStyles color) newColor,
      {String? themeId}) {
    return copyWith(
        style: TextStyle(
            color: newColor(ThemeColor.get(context, themeId: themeId))));
  }
}

/// [BuildContext] Extensions
extension NyApp on BuildContext {
  ColorStyles get color => ThemeColor.get(this);
}

/// [TextStyle] Extensions
extension NyTextStyle on TextStyle {
  TextStyle? setColor(
      BuildContext context, Color Function(ColorStyles color) newColor,
      {String? themeId}) {
    return copyWith(color: newColor(ThemeColor.get(context, themeId: themeId)));
  }
}

/// [SvgPicture] Extensions
extension SvgAsset on SvgPicture {
  SvgPicture localAsset() => SvgPicture.asset(
        getSvgAsset((this.bytesLoader as SvgAssetLoader).assetName),
      );
}
