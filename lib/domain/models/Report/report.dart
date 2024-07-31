class ReportModel {
  final List<dynamic>? classifications;
  final double? score;
  final int? stars;
  final String? error;

  ReportModel({this.classifications, this.score, this.stars, this.error});

  Map<String, dynamic> toJson() => {
        'Classifications': classifications,
        'score': score,
        'stars': stars,
        'error': error
      };

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      classifications: json['Classifications'],
      score: json['score'],
      stars: json['stars'],
      error: json['error'],
    );
  }
}
