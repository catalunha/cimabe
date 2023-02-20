import 'package:flutter/material.dart';

class AppPhotoShow extends StatelessWidget {
  final String? photoUrl;
  final double? height;
  final double? width;
  const AppPhotoShow({
    Key? key,
    required this.photoUrl,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: photoUrl != null && photoUrl!.isNotEmpty
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                photoUrl!,
                height: height,
                width: width,
              ),
            )
          : const SizedBox(
              // height: height,
              // width: width,
              child: Icon(Icons.person_outline),
            ),
    );
  }
}
