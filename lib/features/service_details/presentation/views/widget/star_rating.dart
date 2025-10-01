import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  const StarRating({
    super.key,
    required this.rating,
    this.maxStars = 5,
    this.starSize = 16.0,
    this.starColor = Colors.amber,
    this.unratedStarColor = Colors.grey,
    this.allowHalfStars = true,
  });

  final double rating;
  final int maxStars;
  final double starSize;
  final Color starColor;
  final Color unratedStarColor;
  final bool allowHalfStars;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxStars, (index) {
        return Icon(
          _getStarIcon(index),
          size: starSize,
          color: _getStarColor(index),
        );
      }),
    );
  }

  IconData _getStarIcon(int index) {
    double starValue = rating - index;

    if (starValue >= 1.0) {
      return Icons.star;
    } else if (allowHalfStars && starValue >= 0.5) {
      return Icons.star_half;
    } else {
      return Icons.star_border;
    }
  }

  Color _getStarColor(int index) {
    double starValue = rating - index;

    if (starValue >= 0.5) {
      return starColor;
    } else {
      return unratedStarColor;
    }
  }
}
