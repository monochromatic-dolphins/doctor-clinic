import 'package:doctor_clinic/app/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData mainTheme(BuildContext context) => Theme.of(context).copyWith(
    scaffoldBackgroundColor: AppColors.background,
        textTheme: Theme.of(context).textTheme.copyWith(
              bodyText1: _defaultTextStyle.copyWith(fontWeight: FontWeight.bold),
              bodyText2: _defaultTextStyle,
              headline1: _defaultTextStyle.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 48,
              ),
              headline3: _defaultTextStyle.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
              headline6: _defaultTextStyle.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 13,
                color: AppColors.main,
              ),
              button: _defaultTextStyle.copyWith(
                fontSize: 20.0,
              ),
            ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: AppColors.main,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
            elevation: 0.0,
            minimumSize: const Size(double.infinity, 56),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: AppColors.accent,
            textStyle: _defaultTextStyle.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ),
      );

  static InputDecoration defaultTextInputStyle(String label) => InputDecoration(
    labelText: label,
    labelStyle: _defaultTextStyle
  );

  static final TextStyle _defaultTextStyle = GoogleFonts.zillaSlab(
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.w400,
  );
}
