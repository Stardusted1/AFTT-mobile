import 'package:redux/redux.dart';
import '../api/missions_api.dart';
import 'actions.dart';
import 'app_state.dart';

List<Middleware<AppState>> createMiddleware({MissionsApi? api}) {
  final missionsApi = api ?? MissionsApi(baseUrl: 'http://localhost:5000');

  return [
    TypedMiddleware<AppState, LoadMissions>(_loadMissions(missionsApi)),
    TypedMiddleware<AppState, CreateMission>(_createMission(missionsApi)),
    TypedMiddleware<AppState, UpdateMission>(_updateMission(missionsApi)),
    TypedMiddleware<AppState, DeleteMission>(_deleteMission(missionsApi)),
  ];
}

Middleware<AppState> _loadMissions(MissionsApi api) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);
    try {
      final missions = await api.getMissions();
      store.dispatch(MissionsLoaded(missions));
    } catch (e) {
      store.dispatch(MissionsLoadFailed(e.toString()));
    }
  };
}

Middleware<AppState> _createMission(MissionsApi api) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);
    if (action is CreateMission) {
      try {
        final created = await api.createMission(action.mission);
        store.dispatch(MissionCreated(created));
      } catch (e) {
        store.dispatch(MissionCreateFailed(e.toString()));
      }
    }
  };
}

Middleware<AppState> _updateMission(MissionsApi api) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);
    if (action is UpdateMission) {
      try {
        final updated = await api.updateMission(action.mission);
        store.dispatch(MissionUpdated(updated));
      } catch (e) {
        store.dispatch(MissionUpdateFailed(e.toString()));
      }
    }
  };
}

Middleware<AppState> _deleteMission(MissionsApi api) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);
    if (action is DeleteMission) {
      try {
        await api.deleteMission(action.id);
        store.dispatch(MissionDeleted(action.id));
      } catch (e) {
        store.dispatch(MissionDeleteFailed(e.toString()));
      }
    }
  };
}
