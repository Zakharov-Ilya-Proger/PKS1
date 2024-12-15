import 'package:pks3/models/AnalysisItem.dart';

class CartItem{
  final Analyze item;
  int count = 1;
  CartItem(this.item);
}

class CartAnalyze {
  final int analyzeId;
  final int count;

  CartAnalyze({required this.analyzeId, required this.count});

  factory CartAnalyze.fromJson(Map<String, dynamic> json) {
    return CartAnalyze(
      analyzeId: json['analyze_id'],
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'analyze_id': analyzeId,
      'count': count,
    };
  }
}