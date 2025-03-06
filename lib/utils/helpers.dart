import 'dart:convert';
import 'package:intl/intl.dart';

class Helpers {
  // Formata valores monetários
  static String formatCurrency(double amount, String currencySymbol) {
    final formatter =
        NumberFormat.currency(symbol: currencySymbol, decimalDigits: 2);
    return formatter.format(amount);
  }

  // Calcula a variação percentual entre dois valores
  static String calculatePercentageChange(double oldValue, double newValue) {
    if (oldValue == 0) return 'N/A'; // Prevenção de divisão por zero
    double percentage = ((newValue - oldValue) / oldValue) * 100;
    return '${percentage.toStringAsFixed(2)}%';
  }

  // Converte timestamp para uma data legível
  static String formatDate(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('dd/MM/yyyy').format(date);
  }

  // Valida se a resposta da API contém erro
  static bool isApiResponseValid(Map<String, dynamic> response) {
    if (response.containsKey('error')) {
      print('Erro na API: ${response['error']}');
      return false;
    }
    return true;
  }

  // Converte JSON String para Map
  static Map<String, dynamic> parseJson(String jsonString) {
    return jsonDecode(jsonString);
  }
}
