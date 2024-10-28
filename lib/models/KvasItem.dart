class KvasItem {
  final int ID;
  final String name;
  final String description;
  final String imageUrl;
  bool lovely = false;

  KvasItem({
    required this.ID,
    required this.name,
    required this.description,
    required this.imageUrl
  });

  factory KvasItem.fromJson(Map<String, dynamic> json) {
    return KvasItem(
      ID: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['image_url']
    );
  }
}