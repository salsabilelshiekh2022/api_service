class RateRequestModel {
  final int rate;
  final String? comment;

  RateRequestModel({
    required this.rate,
    this.comment,
  });

  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      'comment': comment,
    };
  }
}
