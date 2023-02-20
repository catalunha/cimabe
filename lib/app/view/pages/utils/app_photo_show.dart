import 'package:flutter/material.dart';

class AppPhotoShow extends StatelessWidget {
  final String? photoUrl;
  final double height;
  final double width;
  const AppPhotoShow({
    Key? key,
    required this.photoUrl,
    this.height = 58,
    this.width = 58,
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
          : SizedBox(
              height: height,
              width: width,
              child: const Icon(Icons.person_outline),
            ),
    );
  }
}
