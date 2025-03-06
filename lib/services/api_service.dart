import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:global_money/services/secure_service.dart';
import 'package:global_money/utils/constants.dart';
import 'package:global_money/utils/helpers.dart';
import 'package:http/http.dart' as http;
import '../models/currency_model.dart';
import '../models/stock_model.dart';

class ApiService {
  final SecureStorageService _secureStorage;

  ApiService(this._secureStorage);

  Future<Map<String, String>> _getHeaders() async {
    final token = await _secureStorage.getBrapiToken();
    return {
      'Authorization': 'Bearer ${token ?? ''}',
    };
  }

  Future<List<CurrencyModel>> fetchCurrencies() async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(
        Uri.parse('${Constants.brapiBaseUrl}/v2/currency'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (!Helpers.isApiResponseValid(data)) return [];

        return (data['currency'] as List)
            .map((item) => CurrencyModel.fromJson(item))
            .toList();
      } else {
        throw Exception('Erro ao buscar moedas');
      }
    } catch (e) {
      debugPrint('Erro na API: $e');
      return [];
    }
  }

  Future<List<StockModel>> fetchStocks(List<String> tickers) async {
    try {
      final headers = await _getHeaders();
      final String tickerQuery = tickers.join(',');
      final response = await http.get(
        Uri.parse('${Constants.brapiBaseUrl}/quote/$tickerQuery'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (!Helpers.isApiResponseValid(data)) return [];

        return (data['results'] as List)
            .map((item) => StockModel.fromJson(item))
            .toList();
      } else {
        throw Exception('Erro ao buscar ações');
      }
    } catch (e) {
      debugPrint('Erro na API: $e');
      return [];
    }
  }

  Future<List<StockModel>> fetchStockHistory(String ticker) async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(
        Uri.parse(
            '${Constants.brapiBaseUrl}/quote/$ticker/history?interval=1d&range=3mo'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (!Helpers.isApiResponseValid(data)) return [];

        return (data['historicalDataPrice'] as List)
            .map((item) => StockModel.fromJson(item))
            .toList();
      } else {
        throw Exception('Erro ao buscar histórico de ações');
      }
    } catch (e) {
      debugPrint('Erro na API: $e');
      return [];
    }
  }
}
