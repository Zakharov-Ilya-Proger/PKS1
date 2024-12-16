class Analyze {
  final int id;
  final String title;
  final int cost;
  final String days;
  final String type;
  final bool favorite;

  Analyze({
    required this.id,
    required this.title,
    required this.cost,
    required this.days,
    required this.type,
    required this.favorite
  });

  factory Analyze.fromJson(Map<String, dynamic> json) {
    return Analyze(
      id: json['id'],
      title: json['title'],
      cost: json['cost'],
      days: json['days'],
      type: json['type'],
      favorite: json['is_favorite']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'cost': cost,
      'days': days,
      'type': type,
      'is_favorite': favorite
    };
  }
}