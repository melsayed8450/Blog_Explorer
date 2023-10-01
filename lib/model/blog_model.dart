class BlogModel {
  BlogModel({
    this.id,
    this.imageUrl,
    this.title,
  });
  String? id;
  String? imageUrl;
  String? title;
  
  BlogModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    imageUrl = json['image_url'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['image_url'] = imageUrl;
    data['title'] = title;
    return data;
  }
}