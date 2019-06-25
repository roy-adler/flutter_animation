import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'dart:math';

import './loader.dart';

/**
 * Creates the GridView
 */
class ImageGrid extends StatefulWidget {
  @override
  _ImageGridState createState() => _ImageGridState();
}

class _ImageGridState extends State<ImageGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this produces 2 rows.
      crossAxisCount: 3,
      // Generate 100 widgets that display their index in the List.
      children: List.generate(100, (index) {
        return (GridItem('$index'));
      }),
    );
  }
}


/**
 * Item for Grid with Image, Text and Functionality
 */
class GridItem extends StatelessWidget {
  final BaseCacheManager _cacheManager = DefaultCacheManager();
  final String itemNumber;
  final String _imageURL =
      'https://picsum.photos/id/' + Random().nextInt(100).toString() + '/200';

  GridItem(this.itemNumber);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        getImage(),
        Text(
          'Item ' + itemNumber,
        ),
      ],
    );
  }

  Widget getImage(){
    return Image.network(_imageURL, width: 120.0,);
  }

  Widget getImageOld() {
    final size = 120.0;

    final title = 'Cached Images';
    var networkImage = new CachedNetworkImage(

      width: size,
      height: size,
      placeholder: (context, url) => CircularProgressIndicator(),
      imageUrl: _imageURL,
      cacheManager: _cacheManager,

    );

    return (networkImage);
  }
}