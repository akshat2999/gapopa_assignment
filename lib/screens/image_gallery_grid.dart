import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:provider/provider.dart';

import '../manager/gallery_grid_manager.dart';
import '../model/image_model.dart';
import '../widgets/image_item.dart';

class GalleryPage extends StatefulWidget {
  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State {
  TextEditingController searchController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    Provider.of<GalleryProvider>(context, listen: false).fetchImages();

    super.initState();
    searchController.addListener(() {
      EasyDebounce.debounce(
        'search',
        Duration(milliseconds: 2000),
        () => Provider.of<GalleryProvider>(context, listen: false)
            .onSearchTextChanged(searchController.text),
      );
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        Provider.of<GalleryProvider>(context, listen: false)
            .fetchImages(query: searchController.text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            constraints: BoxConstraints(maxWidth: 300),
            child: TextField(
                controller: searchController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.5),
                  hintText: 'Search images...(with debounce of 2seconds)',
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(50)),
                )),
          ),
        ),
      ),
      body: Consumer<GalleryProvider>(builder: (_, provider, __) {
        return Padding(
          padding: const EdgeInsets.only(top: 18.0, left: 25),
          child: GridView.builder(
            controller: _scrollController,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width ~/ 200,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 1),
            itemCount: provider.images.length,
            itemBuilder: (BuildContext context, int index) {
              return ImageItem(imageData: provider.images[index]);
            },
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
