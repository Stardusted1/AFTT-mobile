import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/mission_dto.dart';

class MissionsApi {
  final String baseUrl;
  final http.Client _client;

  MissionsApi({required this.baseUrl, http.Client? client})
      : _client = client ?? http.Client();

  Future<List<MissionDto>> getMissions() async {
    final response = await _client.get(Uri.parse('$baseUrl/api/missions'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      return data.map((e) => MissionDto.fromJson(e)).toList();
    }
    throw Exception('Failed to load missions');
  }

  Future<MissionDto> createMission(MissionDto mission) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/api/missions'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(mission.toJson()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return MissionDto.fromJson(json.decode(response.body));
    }
    throw Exception('Failed to create mission');
  }

  Future<MissionDto> updateMission(MissionDto mission) async {
    final response = await _client.put(
      Uri.parse('$baseUrl/api/missions'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(mission.toJson()),
    );
    if (response.statusCode == 200) {
      return MissionDto.fromJson(json.decode(response.body));
    }
    throw Exception('Failed to update mission');
  }

  Future<void> deleteMission(String id) async {
    final response = await _client.delete(Uri.parse('$baseUrl/api/missions/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete mission');
    }
  }
}
