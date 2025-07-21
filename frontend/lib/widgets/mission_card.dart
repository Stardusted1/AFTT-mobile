import 'package:flutter/material.dart';
import '../models/mission_dto.dart';

class MissionCard extends StatelessWidget {
  final MissionDto mission;
  final VoidCallback? onTap;

  const MissionCard({Key? key, required this.mission, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(mission.title),
        subtitle: Text(mission.description ?? ''),
        trailing: Text(mission.status),
        onTap: onTap,
      ),
    );
  }
}
