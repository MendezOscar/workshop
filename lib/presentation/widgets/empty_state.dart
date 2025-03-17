import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String pathImage;
  final String message;
  final String title;
  const EmptyState({
    Key? key,
    required this.pathImage,
    required this.title,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 0,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.block, size: 40),
                  const SizedBox(height: 20),
                  Text(title,
                      style: const TextStyle(
                          color: Color(0XFF0879A6),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          height: 1.5)),
                  const SizedBox(height: 10),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: message,
                        style: const TextStyle(
                            color: Color(0XFF0879A6),
                            fontSize: 16,
                            height: 1.5)),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
