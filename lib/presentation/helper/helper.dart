import 'package:flutter/material.dart';

class Helper {
  //Function for snackbar.
  static void showCustomSnackbar(
    BuildContext context, {
    required String message,
    Color backgroundColor = Colors.black,
    Color textColor = Colors.white,
    double fontSize = 16,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: textColor, fontSize: fontSize),
        ),
        backgroundColor: backgroundColor,
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  //function to show category color.
  static Color getColorFromCategory(String category) {
    switch (category.toLowerCase()) {
      case 'home':
        return Colors.red;
      case 'university':
        return Colors.blue;
      case 'work':
        return Colors.orange;
      case 'grocery':
        return Colors.green;
      case 'sport':
        return Colors.teal;
      case 'social':
        return Colors.purple;
      case 'music':
        return Colors.pink;
      case 'health':
        return Colors.greenAccent;
      case 'movie':
        return Colors.lightBlue;
      default:
        return Colors.grey;
    }
  }

  //function to show category Icon.
  static IconData getIconFromCategory(String category) {
    switch (category.toLowerCase()) {
      case 'home':
        return Icons.home;
      case 'university':
        return Icons.school;
      case 'work':
        return Icons.work;
      case 'grocery':
        return Icons.local_grocery_store;
      case 'sport':
        return Icons.fitness_center;

      case 'social':
        return Icons.campaign;
      case 'music':
        return Icons.music_note;
      case 'health':
        return Icons.favorite;
      case 'movie':
        return Icons.movie;

      default:
        return Icons.help_outline;
    }
  }
}
