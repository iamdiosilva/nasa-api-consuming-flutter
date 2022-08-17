import 'package:flutter/material.dart';

import '../models/image_model.dart';

class DetailPage extends StatelessWidget {
  final ImageModel imageModel;

  const DetailPage({Key? key, required this.imageModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(imageModel.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            imageModel.mediaType == 'video'
                ? Image.network(
                    'https://images-na.ssl-images-amazon.com/images/I/6111kA98OPL.png',
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    imageModel.urlImg,
                    fit: BoxFit.cover,
                  ),
            const SizedBox(height: 20),
            Text(
              imageModel.explanation,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'Date: ${imageModel.date}\nCopyright: ${imageModel.copyright}',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
