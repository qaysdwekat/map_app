import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OOTImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;
  final String? package;
  final String? placeholder;

  const OOTImage({
    required this.imageUrl,
    Key? key,
    this.width,
    this.height,
    this.fit,
    this.color,
    this.package,
    this.placeholder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isSvgImage = imageUrl.split('.').last == 'svg';

    if (imageUrl.isEmpty) {
      return const SizedBox();
    }

    if (!imageUrl.contains('http')) {
      return loadLocalAsset(imageUrl);
    }

    if (isSvgImage) {
      return SvgPicture.network(
        imageUrl,
        width: width,
        height: height,
        fit: fit ?? BoxFit.contain,
        color: color,
      );
    }

    return ExtendedImage.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      color: color,
      loadStateChanged: (state) {
        switch (state.extendedImageLoadState) {
          case LoadState.completed:
            return state.completedWidget;
          case LoadState.loading:
          case LoadState.failed:
            return (placeholder != null) ? loadLocalAsset(placeholder!) : const SizedBox();
          default:
            return const SizedBox();
        }
      },
    );
  }

  Widget loadLocalAsset(String imageUrl) {
    var isSvgImage = imageUrl.split('.').last == 'svg';

    if (isSvgImage) {
      return SvgPicture.asset(
        imageUrl,
        width: width,
        height: height,
        fit: fit ?? BoxFit.contain,
        color: color,
        package: package,
      );
    }
    return Image.asset(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      color: color,
      package: package,
    );
  }
}
