import 'package:flutter/material.dart';
import 'package:ammar_fe_flutter/widget/image_load.dart';

class ImagePreviewPage extends StatelessWidget {
  const ImagePreviewPage({
    super.key,
    required this.src,
    this.isAsset = false,
    this.title,
    this.titleStyle,
  });

  final String src;
  final bool isAsset;
  final String? title;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title ?? '', style: titleStyle)),
      body: Center(
        child: InteractiveViewer(
          child: BaseImage(src: src, isAsset: isAsset, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
