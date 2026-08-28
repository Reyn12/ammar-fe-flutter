import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ammar_fe_flutter/helper/image_helper.dart';
import 'package:ammar_fe_flutter/helper/string_extensions.dart';
import 'package:ammar_fe_flutter/widget/image_preview_page.dart';
import 'package:ammar_fe_flutter/widget/loading_overlay.dart';

enum ShapeImage { oval, react, circle }

class ImageLoad extends StatelessWidget {
  final String? src;
  final double? width;
  final double? height;
  final VoidCallback? onTap;
  final BorderRadiusGeometry? borderRadius;
  final BoxFit fit;
  final Color? color;
  final Widget? errorWidget;
  final Widget? loadingWidget;
  final Alignment alignment;
  final ShapeImage shapeImage;

  /// Called this placeholder src when [src] is null or empty
  /// If you fill the [generateByName], this placeholderSrc will be replace
  /// or not work
  final String? placeholderSrc;

  /// BoxFit for placeholder
  final BoxFit? placeholderFit;

  /// Custom widget that called when [src] is null or empty
  final Widget? placeholderWidget;

  /// If true -> enable on tap to redirect MediaPreview Page
  final bool enablePreview;
  final String? previewTitle;
  final TextStyle? previewTitleStyle;

  /// Must be set to true manually if you need load from asset
  /// but the source (src) is not from
  ///
  /// **(lib/resources/.. )** or **(assets/.. )**
  final bool isAsset;

  /// Fill this to generated network image source by given Name.
  /// If you fill this field and [placeholderSrc], the placeholderSrc will not work
  final String? generateByName;

  final BoxBorder? border;

  const ImageLoad({
    super.key,
    this.src,
    this.width,
    this.height,
    this.onTap,
    this.borderRadius,
    this.fit = BoxFit.cover,
    this.enablePreview = false,
    this.placeholderFit,
    this.placeholderWidget,
    this.placeholderSrc,
    this.isAsset = false,
    this.color,
    this.previewTitle,
    this.previewTitleStyle,
    this.errorWidget,
    this.loadingWidget,
    this.shapeImage = ShapeImage.react,
    this.alignment = Alignment.center,
    this.generateByName,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    if (src.isNotNullAndNotEmpty) {
      return BaseImage(
        src: src.toString(),
        width: width,
        height: height,
        fit: fit,
        borderRadius: borderRadius,
        enablePreview: enablePreview,
        onTapImage: onTap,
        isAsset: isAsset,
        color: color,
        previewTitle: previewTitle,
        previewTitleStyle: previewTitleStyle,
        errorWidget: errorWidget,
        loadingWidget: loadingWidget,
        shapeImage: shapeImage,
        alignment: alignment,
        border: border,
      );
    }

    return placeholderWidget ??
        BaseImage(
          src: generateByName.isNotNullAndNotEmpty
              ? ImageHelper.generateAvatarByName(generateByName ?? 'user')
              : placeholderSrc ?? 'assets/images/img_logo_splash.png',
          width: width,
          height: height,
          fit: placeholderFit ?? BoxFit.contain,
          borderRadius: borderRadius,
          enablePreview: enablePreview,
          onTapImage: onTap,
          isAsset: isAsset,
          color: color,
          previewTitle: previewTitle,
          previewTitleStyle: previewTitleStyle,
          shapeImage: shapeImage,
          alignment: alignment,
          border: border,
        );
  }
}

class BaseImage extends StatelessWidget {
  final String src;
  final double? width;
  final double? height;
  final VoidCallback? onTapImage;
  final BorderRadiusGeometry? borderRadius;
  final BoxFit fit;
  final bool enablePreview;
  final bool isAsset;
  final Color? color;
  final String? previewTitle;
  final TextStyle? previewTitleStyle;
  final Widget? errorWidget;
  final Widget? loadingWidget;
  final ShapeImage shapeImage;
  final Alignment alignment;
  final BoxBorder? border;

  const BaseImage({
    super.key,
    required this.src,
    this.width,
    this.height,
    this.onTapImage,
    this.borderRadius,
    this.fit = BoxFit.fill,
    this.enablePreview = false,
    this.isAsset = false,
    this.color,
    this.previewTitle,
    this.previewTitleStyle,
    this.errorWidget,
    this.loadingWidget,
    this.shapeImage = ShapeImage.react,
    this.alignment = Alignment.center,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    if (shapeImage == ShapeImage.circle) {
      assert(
        height != null && width != null,
        'Height and Width cannot be null if shapeImage is ShapeImage.circle.',
      );
    }

    return InkWell(
      onTap: enablePreview
          ? () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => ImagePreviewPage(
                    src: src,
                    isAsset: isAsset,
                    title: previewTitle,
                    titleStyle: previewTitleStyle,
                  ),
                ),
              );
            }
          : onTapImage,
      child: _determineShapeImage(),
    );
  }

  Widget _determineShapeImage() {
    switch (shapeImage) {
      case ShapeImage.circle:
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(shape: BoxShape.circle, border: border),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(height! / 2),
            child: _determineImageWidget(),
          ),
        );
      case ShapeImage.oval:
        return ClipOval(child: _determineImageWidget());
      case ShapeImage.react:
        return ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(0),
          child: _determineImageWidget(),
        );
    }
  }

  Widget _determineImageWidget() {
    final bool isFromRemote = src.startsWith('http');
    final bool isSvg = src.endsWith('.svg');
    final bool isAssets =
        isAsset ||
        src.startsWith('lib/resources/') ||
        src.startsWith('assets/');

    if (isFromRemote) {
      return CachedNetworkImage(
        imageUrl: src,
        color: color,
        fit: fit,
        width: width,
        height: height,
        alignment: alignment,
        placeholder: (context, url) => SizedBox(
          height: height,
          width: width,
          child:
              loadingWidget ??
              LoadingOverlay(
                size: (height ?? 0) < 30 ? (height ?? 0) / 4 : null,
              ),
        ),
        errorWidget: (context, url, error) {
          debugPrint('Error load network image $url $error');
          return SizedBox(
            height: height,
            width: width,
            child: errorWidget ?? const Icon(Icons.error),
          );
        },
      );
    }

    if (isSvg) {
      return SvgPicture.asset(
        src,
        width: width,
        height: height,
        colorFilter: color != null
            ? ColorFilter.mode(color!, BlendMode.srcIn)
            : null,
        fit: fit,
        alignment: alignment,
        errorBuilder: (context, error, stackTrace) {
          debugPrint('Error load asset image $error');
          return SizedBox(
            height: height,
            width: width,
            child: errorWidget ?? const Icon(Icons.error),
          );
        },
      );
    }

    if (isAssets) {
      return Image.asset(
        src,
        width: width,
        height: height,
        fit: fit,
        color: color,
        alignment: alignment,
        errorBuilder: (context, error, stackTrace) {
          debugPrint('Error load asset image $error');
          return SizedBox(
            height: height,
            width: width,
            child: errorWidget ?? const Icon(Icons.error),
          );
        },
      );
    }

    return Image.file(
      File(src),
      width: width,
      height: height,
      fit: fit,
      color: color,
      alignment: alignment,
      errorBuilder: (context, error, stackTrace) {
        debugPrint('Error load file image $error');
        return SizedBox(
          height: height,
          width: width,
          child: errorWidget ?? const Icon(Icons.error),
        );
      },
    );
  }
}
