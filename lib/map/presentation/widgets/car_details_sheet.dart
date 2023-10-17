import 'package:flutter/material.dart';

class CarDetailsBottomSheet extends StatelessWidget {
  final Function onTap;
  const CarDetailsBottomSheet({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'Car Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                  onPressed: () => onTap(), icon: const Icon(Icons.clear))
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
