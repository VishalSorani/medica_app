class SliderModel {
  final String id;
  final String heading;
  final String text;
  final String imageUrl;

  SliderModel({
    required this.id,
    required this.heading,
    required this.text,
    required this.imageUrl,
  });

  factory SliderModel.fromJson(Map<String, dynamic> json, String id) {
    return SliderModel(
      id: id,
      heading: json['heading'],
      text: json['text'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'heading': heading,
      'text': text,
      'imageUrl': imageUrl,
    };
  }
}
