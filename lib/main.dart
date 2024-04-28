import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'manager/gallery_grid_manager.dart';
import 'screens/image_gallery_grid.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GalleryProvider()),
      ],
      builder: (context, child) => MaterialApp(
        title: 'Pixabay Gallery',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: GalleryPage(),
      ),
    );
  }
}
