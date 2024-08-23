import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:mars_rover/src/constant.dart';

class MyImage extends StatelessWidget {
  final String url;
  final double radiusTop;
  final double radiusBottom;
  final double? width;
  final double? height;

  const MyImage({
    super.key,
    required this.url,
    this.radiusTop = 0,
    this.radiusBottom = 0,
    this.width = double.infinity,
    this.height = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radiusTop),
          topRight: Radius.circular(radiusTop),
          bottomLeft: Radius.circular(radiusBottom),
          bottomRight: Radius.circular(radiusBottom)),
      child: CachedNetworkImage(
        imageUrl: url,
        width: width,
        height: height,
        filterQuality: FilterQuality.high,
        fit: BoxFit.cover,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            const Center(child: CupertinoActivityIndicator(color: kRedColor)),
        errorWidget: (context, url, error) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset("assets/placeholder_image.png"),
        ),
      ),
    );
  }
}
