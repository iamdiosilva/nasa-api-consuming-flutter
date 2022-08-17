import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/image_model.dart';

class ImagesRepositorie extends ChangeNotifier {
  List<ImageModel> _imagesInformation = [];

  List<ImageModel> get imagesList => _imagesInformation;

  ImagesRepositorie() {
    _readDirectlyAPI();
  }

  _readDirectlyAPI() async {
    String uri = 'https://api.nasa.gov/planetary/apod?count=20&api_key=C09Atnmtxqs9KJ8grxHtV3F2wqmrICPy9QfuJp0P';

    final response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body);

      if (jsonList is List) {
        _imagesInformation = jsonList.map((json) => ImageModel.fromJson(json)).toList();
      }
    }
    notifyListeners();
  }

  refresh() {
    _imagesInformation.clear();
    _readDirectlyAPI();
  }
}
