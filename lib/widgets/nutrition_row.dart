import 'package:flutter/material.dart';

class NutritionRow extends StatelessWidget {
  final String label;
  final dynamic value;
  final String unit;
  final dynamic dailyValue;

  const NutritionRow({
    super.key,
    required this.label,
    required this.value,
    required this.unit,
    this.dailyValue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$label: $value $unit", style: const TextStyle(fontSize: 16)),
          if (dailyValue != null)
            Text("(${dailyValue.toStringAsFixed(1)}%)",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
