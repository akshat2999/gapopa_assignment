import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';

import '../model/image_model.dart';

class GalleryProvider extends ChangeNotifier {
  List<ImageData> images = [];
  bool isLoading = false;
  int currentPage = 1;

  Future<void> fetchImages({String query = ""}) async {
    isLoading = true;
    notifyListeners();

    try {
      String apiKey = '43602587-d2029029482099a80c74c2f9f';
      String url =
          'https://pixabay.com/api/?key=$apiKey&q=$query&page=$currentPage&per_page=50';
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        List<ImageData> fetchedImages = [];
        for (var item in data['hits']) {
          fetchedImages.add(ImageData.fromJson(item));
        }
        images.addAll(fetchedImages);
        isLoading = false;
        currentPage++;
        notifyListeners();
      } else {
        throw Exception('Failed to load images');
      }
    } catch (error) {
      isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  void onSearchTextChanged(String text) {
    images.clear();
    currentPage = 1;
    fetchImages(query: text);
    notifyListeners();
  }
}
