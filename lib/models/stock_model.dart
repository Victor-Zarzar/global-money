class StockModel {
  final String name;
  final String code;
  final double points;
  final double variation;

  StockModel({
    required this.name,
    required this.code,
    required this.points,
    required this.variation,
  });

  factory StockModel.fromJson(Map<String, dynamic> json) {
    return StockModel(
      name: json['name'],
      code: json['code'],
      points: json['points']?.toDouble() ?? 0.0,
      variation: json['variation']?.toDouble() ?? 0.0,
    );
  }
}
