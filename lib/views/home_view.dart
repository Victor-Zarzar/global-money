import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:global_money/features/app_theme.dart';
import 'package:global_money/features/theme_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
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
      );
    });
  }
}
