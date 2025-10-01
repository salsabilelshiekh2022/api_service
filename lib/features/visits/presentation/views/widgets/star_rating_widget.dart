import 'package:flutter/material.dart';

class StarRatingWidget extends StatelessWidget {
  const StarRatingWidget({
    super.key,
    required this.selectedRating,
    required this.onRatingChanged,
  });

  final int selectedRating;
  final Function(int) onRatingChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 4,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () {
            onRatingChanged(index + 1);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 4,
            ),
            child: Icon(
              Icons.star,
              size: 44,
              color:
                  index < selectedRating ? Colors.amber : Colors.grey.shade300,
            ),
          ),
        );
      }),
    );
  }
}
