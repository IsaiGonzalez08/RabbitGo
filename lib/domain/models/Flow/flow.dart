class FlowModel {
  final double speed, speedUncapped, freeFlow, jamFactor, confidence;
  final String traversability;

  FlowModel({
    required this.speed,
    required this.speedUncapped,
    required this.freeFlow,
    required this.jamFactor,
    required this.confidence,
    required this.traversability,
  });

  factory FlowModel.fromJson(Map<String, dynamic> json) {
    return FlowModel(
      speed: json['speed'],
      speedUncapped: json['speedUncapped'],
      freeFlow: json['freeFlow'],
      jamFactor: json['jamFactor'],
      confidence: json['confidence'],
      traversability: json['traversability'],
    );
  }
}
