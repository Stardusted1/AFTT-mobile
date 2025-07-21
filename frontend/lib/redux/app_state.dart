import '../models/mission_dto.dart';

class AppState {
  final List<MissionDto> missions;
  final bool isLoading;
  final String? error;

  AppState({required this.missions, required this.isLoading, this.error});

  factory AppState.initial() => AppState(missions: [], isLoading: false);

  AppState copyWith({List<MissionDto>? missions, bool? isLoading, String? error}) {
    return AppState(
      missions: missions ?? this.missions,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
