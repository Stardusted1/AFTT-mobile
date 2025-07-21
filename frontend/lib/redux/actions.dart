import '../models/mission_dto.dart';

class LoadMissions {}
class MissionsLoaded {
  final List<MissionDto> missions;
  MissionsLoaded(this.missions);
}
class MissionsLoadFailed { final String error; MissionsLoadFailed(this.error); }

class CreateMission { final MissionDto mission; CreateMission(this.mission); }
class MissionCreated { final MissionDto mission; MissionCreated(this.mission); }
class MissionCreateFailed { final String error; MissionCreateFailed(this.error); }

class UpdateMission { final MissionDto mission; UpdateMission(this.mission); }
class MissionUpdated { final MissionDto mission; MissionUpdated(this.mission); }
class MissionUpdateFailed { final String error; MissionUpdateFailed(this.error); }

class DeleteMission { final String id; DeleteMission(this.id); }
class MissionDeleted { final String id; MissionDeleted(this.id); }
class MissionDeleteFailed { final String error; MissionDeleteFailed(this.error); }
