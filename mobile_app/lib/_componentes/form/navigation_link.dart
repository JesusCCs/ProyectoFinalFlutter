import 'package:flutter/material.dart';

/// Una clase de apoyo para gestionar los enalces que nos llevan a toras apantallas
/// al inicio de la app. La intención era tener un componente que fuese similar
/// al tag anchor de HTML
class NavigationLink extends StatelessWidget {
  final String text;
  final StatefulWidget screen;

  const NavigationLink({required this.text, required this.screen});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => screen,
        ),
      ),
      child: RichText(
        text: TextSpan(
          text: text,
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
