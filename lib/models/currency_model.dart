class CurrencyModel {
  final String name;
  final String code;
  final double buy;
  final double sell;
  final double variation;

  CurrencyModel({
    required this.name,
    required this.code,
    required this.buy,
    required this.sell,
    required this.variation,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      name: json['name'],
      code: json['code'],
      buy: json['buy']?.toDouble() ?? 0.0,
      sell: json['sell']?.toDouble() ?? 0.0,
      variation: json['variation']?.toDouble() ?? 0.0,
    );
  }
}
