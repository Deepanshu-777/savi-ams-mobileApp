import 'package:flutter/material.dart';
import 'package:rail_weld/data/strings.dart';
import 'package:rail_weld/theme/app_colors.dart';
import 'package:rail_weld/widgets/attachment_viewer.dart';
import 'package:rail_weld/widgets/custom_sized_box.dart';
import 'package:rail_weld/widgets/custom_text.dart';

import 'package:cached_network_image/cached_network_image.dart';

Widget singleAttachmentsContainer({
  required String? imageUrl,
  required double width,
}) {
  final hasAttachment = imageUrl?.isNotEmpty == true;

  return hasAttachment
      ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customSizedBox(height: 20),
            mediumText(
              title: Strings.ATTACHMENT,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontColor: AppColors.black,
            ),
            customSizedBox(height: 14),
            GestureDetector(
              onTap: () => attachmentViewer(
                width: width,
                imgPath: imageUrl,
              ),
              child: Container(
                height: 100,
                width: width * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    width: 0.7,
                    color: AppColors.black,
                  ),
                ),
                clipBehavior: Clip.hardEdge,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8), // SAME RADIUS
                  child: CachedNetworkImage(
                    imageUrl: imageUrl!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(strokeWidth: 1.5),
                    ),
                    errorWidget: (context, url, error) => const Center(
                      child: Icon(Icons.broken_image,
                          size: 40, color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      : const SizedBox();
}
