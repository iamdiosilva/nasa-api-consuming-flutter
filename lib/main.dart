import 'package:flutter/material.dart';
import 'package:nasa_images_explorer/app.dart';
import 'package:provider/provider.dart';

import 'repositories/images_repositorie.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ImagesRepositorie()),
      ],
      child: const App(),
    ),
  );
}
