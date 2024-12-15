class Analyze {
  final int id;
  final String title;
  final int cost;
  final String days;

  Analyze({required this.id, required this.title, required this.cost, required this.days});

  factory Analyze.fromJson(Map<String, dynamic> json) {
    return Analyze(
      id: json['id'],
      title: json['title'],
      cost: json['cost'],
      days: json['days'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'cost': cost,
      'days': days,
    };
  }
}