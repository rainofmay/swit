class AudioModel {
  final int id;
  final String name;
  final String theme;
  final String audioURL;

  AudioModel({
    required this.id,
    required this.name,
    required this.theme,
    required this.audioURL,
  });

  factory AudioModel.fromJson(Map<String, dynamic> json) {
    return AudioModel(
      id: json['id'],
      name: json['name'],
      theme: json['theme'],
      audioURL: json['audioURL'],
    );
  }
}