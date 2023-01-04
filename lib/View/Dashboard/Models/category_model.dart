

class CategoryModel {
  String id;
  String title;
  String description;
  String image;
  String type;

  CategoryModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.image,
      required this.type});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id'].toString(),
      title: json['title'].toString(),
      description: json['description'].toString(),
      image: json['image'].toString(),
      type: json['type'].toString(),
    );
  }
}
