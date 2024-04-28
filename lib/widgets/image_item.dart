import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/image_model.dart';
import '../screens/full_screen_image.dart';
import '../screens/image_gallery_grid.dart';

class ImageItem extends StatelessWidget {
  final ImageData imageData;

  const ImageItem({Key? key, required this.imageData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FullScreenImage(imageData: imageData),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: imageData.id,
            child: CachedNetworkImage(
              imageUrl: imageData.imageUrl,
              height: 150,
              width: 150,
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(
                  child: SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator())),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          SizedBox(height: 8.0),
          Text('Likes: ${imageData.likes} Views: ${imageData.views}'),
        ],
      ),
    );
  }
}
