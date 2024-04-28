import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../model/image_model.dart';
import 'image_gallery_grid.dart';

class FullScreenImage extends StatelessWidget {
  final ImageData imageData;

  const FullScreenImage({Key? key, required this.imageData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Full Screen Image (click on the image to go back)'),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          child: Center(
            child: Hero(
              tag: imageData.id,
              child: CachedNetworkImage(
                imageUrl: imageData.imageUrl,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
