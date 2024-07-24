class ReportModel {
  final List<dynamic> classifications;
  final double score;
  final int stars;

  ReportModel({
    required this.classifications,
    required this.score,
    required this.stars
  });

  Map<String, dynamic> toJson() => {
        'Classifications': classifications,
        'score': score,
        'stars': stars
      };

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      classifications: json['Classifications'],
      score: json['score'],
      stars: json['stars']
    );
  }
}
