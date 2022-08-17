import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../repositories/images_repositorie.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ImagesRepositorie imagesRepositorie;
  TextEditingController valueController = TextEditingController();

  int length = 20;

  @override
  Widget build(BuildContext context) {
    imagesRepositorie = context.watch<ImagesRepositorie>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Nasa Images Explorer'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Form(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: TextFormField(
                        controller: valueController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          labelText: 'Number of images',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          length = _returnCount();
                        });
                      },
                      child: const Text('Change')),
                ],
              ),
            ),
            (imagesRepositorie.imagesList.isNotEmpty)
                ? Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        imagesRepositorie.refresh();
                      },
                      child: ListView.builder(
                        itemCount: (imagesRepositorie.imagesList.isNotEmpty) ? length : 0,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                    imageModel: imagesRepositorie.imagesList[index],
                                  ),
                                ),
                              );
                            },
                            child: ListTile(
                              title: Text(imagesRepositorie.imagesList[index].title),
                              subtitle: Text(imagesRepositorie.imagesList[index].date),
                              leading: imagesRepositorie.imagesList[index].mediaType == 'video'
                                  ? Image.network(
                                      'https://images-na.ssl-images-amazon.com/images/I/6111kA98OPL.png',
                                      width: 60,
                                    )
                                  : Image.network(
                                      imagesRepositorie.imagesList[index].urlImg,
                                      width: 60,
                                    ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                : Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  _returnCount() {
    if (int.parse(valueController.text) > 20) {
      return 20;
    } else {
      return int.parse(valueController.text);
    }
  }
}
