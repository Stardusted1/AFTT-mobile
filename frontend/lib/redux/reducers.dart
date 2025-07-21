import 'package:redux/redux.dart';

import "../models/mission_dto.dart";
import 'app_state.dart';
import 'actions.dart';

AppState appReducer(AppState state, dynamic action) => AppState(
      missions: missionsReducer(state.missions, action),
      isLoading: loadingReducer(state.isLoading, action),
      error: errorReducer(state.error, action),
    );

final missionsReducer = combineReducers<List<MissionDto>>([
  TypedReducer<List<MissionDto>, MissionsLoaded>((state, action) => action.missions),
  TypedReducer<List<MissionDto>, MissionCreated>((state, action) => [...state, action.mission]),
  TypedReducer<List<MissionDto>, MissionUpdated>((state, action) =>
      state.map((m) => m.missionGuid == action.mission.missionGuid ? action.mission : m).toList()),
  TypedReducer<List<MissionDto>, MissionDeleted>((state, action) =>
      state.where((m) => m.missionGuid != action.id).toList()),
]);

final loadingReducer = combineReducers<bool>([
  TypedReducer<bool, LoadMissions>((state, action) => true),
  TypedReducer<bool, MissionsLoaded>((state, action) => false),
  TypedReducer<bool, MissionsLoadFailed>((state, action) => false),
  TypedReducer<bool, CreateMission>((state, action) => true),
  TypedReducer<bool, MissionCreated>((state, action) => false),
  TypedReducer<bool, MissionCreateFailed>((state, action) => false),
  TypedReducer<bool, UpdateMission>((state, action) => true),
  TypedReducer<bool, MissionUpdated>((state, action) => false),
  TypedReducer<bool, MissionUpdateFailed>((state, action) => false),
  TypedReducer<bool, DeleteMission>((state, action) => true),
  TypedReducer<bool, MissionDeleted>((state, action) => false),
  TypedReducer<bool, MissionDeleteFailed>((state, action) => false),
]);

String? errorReducer(String? state, dynamic action) {
  if (action is MissionsLoadFailed ||
      action is MissionCreateFailed ||
      action is MissionUpdateFailed ||
      action is MissionDeleteFailed) {
    return action.error;
  }
  if (action is LoadMissions || action is CreateMission || action is UpdateMission || action is DeleteMission) {
    return null;
  }
  return state;
}
