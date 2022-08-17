class ImageModel {
  String title;
  String urlImg;
  String explanation;
  String date;
  String copyright;
  String mediaType;

  ImageModel({
    required this.title,
    required this.copyright,
    required this.urlImg,
    required this.explanation,
    required this.date,
    required this.mediaType,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      title: json['title'],
      urlImg: json['url'] ?? json['hdurl'],
      explanation: json['explanation'],
      date: json['date'],
      copyright: json['copyright'] ?? 'Nasa',
      mediaType: json['media_type'],
    );
  }
}
