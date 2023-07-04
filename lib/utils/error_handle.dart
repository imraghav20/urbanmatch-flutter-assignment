import 'package:flutter/material.dart';

void displayDialog(context, title, text) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Row(
            children: [
              const Icon(Icons.warning),
              const SizedBox(width: 7),
              Text(title),
            ],
          ),
          content: Text(text)),
    );
