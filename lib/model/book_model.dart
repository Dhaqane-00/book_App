class BookModel {
  String? id;
  String? name;
  String? author;
  String? image;

  BookModel({this.name, this.author, this.image , this.id});

  // Convert BookModel to Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'author': author,
      'image': image,
    };
  }

  // Factory method to create a BookModel from a Map
  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      name: json["name"],
      author: json["author"],
      image: json["image"],
    );
  }
}
