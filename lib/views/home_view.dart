import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:global_money/features/app_theme.dart';
import 'package:global_money/features/theme_provider.dart';
import 'package:global_money/services/api_service.dart';
import 'package:global_money/services/secure_service.dart';
import 'package:global_money/widgets/currency_card.dart';
import 'package:global_money/models/currency_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService _apiService = ApiService(SecureStorageService());
  late Future<List<CurrencyModel>> _currencies;

  @override
  void initState() {
    super.initState();
    _currencies = _apiService.fetchCurrencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UiProvider>(builder: (context, notifier, child) {
      return Scaffold(
        appBar: GFAppBar(
          backgroundColor:
              notifier.isDark ? AppTheme.thirdColor : AppTheme.primaryColor,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'title-appbar'.tr(),
            style: GoogleFonts.jetBrainsMono(
              textStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: notifier.isDark
                    ? TextColor.secondaryColor
                    : TextColor.primaryColor,
              ),
            ),
          ),
        ),
        body: FutureBuilder<List<CurrencyModel>>(
          future: _currencies,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Nenhuma moeda encontrada'));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return CurrencyCard(currency: snapshot.data![index]);
              },
            );
          },
        ),
      );
    });
  }
}
