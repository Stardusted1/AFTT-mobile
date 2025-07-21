class MissionDto {
  final String missionGuid;
  final String title;
  final String? description;
  final String status;
  final int urgency;

  MissionDto({
    required this.missionGuid,
    required this.title,
    this.description,
    required this.status,
    required this.urgency,
  });

  factory MissionDto.fromJson(Map<String, dynamic> json) => MissionDto(
        missionGuid: json['missionGuid'] as String,
        title: json['title'] as String,
        description: json['description'] as String?,
        status: json['status'] as String,
        urgency: json['urgency'] as int,
      );

  Map<String, dynamic> toJson() => {
        'missionGuid': missionGuid,
        'title': title,
        'description': description,
        'status': status,
        'urgency': urgency,
      };
}
