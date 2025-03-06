import 'package:flutter/material.dart';
import 'package:global_money/utils/helpers.dart';
import '../models/currency_model.dart';

class CurrencyCard extends StatelessWidget {
  final CurrencyModel currency;

  const CurrencyCard({super.key, required this.currency});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              currency.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Compra: ${Helpers.formatCurrency(currency.buy, currency.code)}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    Text(
                      'Venda: ${Helpers.formatCurrency(currency.sell, currency.code)}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                Chip(
                  label: Text(
                    Helpers.calculatePercentageChange(
                        currency.buy, currency.sell),
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor:
                      currency.variation >= 0 ? Colors.green : Colors.red,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
