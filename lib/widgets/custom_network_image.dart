import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rail_weld/theme/app_colors.dart';

Widget customNetworkImage({
  BoxFit? fit = BoxFit.cover,
  String? imageUrl,
  double size = 51.67,
  BoxShape shape = BoxShape.circle,
  IconData placeHolder = Icons.person,
  Widget errorIcon = const Icon(
    Icons.person,
    color: AppColors.black,
  ),
}) {
  return Container(
    height: size,
    width: size,
    decoration: const BoxDecoration(
      color: AppColors.black,
      shape: BoxShape.circle,
    ),
    child: CachedNetworkImage(
      imageBuilder: (context, imageProvider) => Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
          ),
          color: AppColors.offWhite,
          shape: shape,
        ),
      ),
      fit: BoxFit.cover,
      imageUrl: imageUrl ?? "",
      errorWidget: (context, url, error) => errorIcon,
      placeholder: (context, url) => Icon(
        placeHolder,
        color: AppColors.offWhite,
      ),
    ),
  );
}
