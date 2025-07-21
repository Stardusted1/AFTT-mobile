import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:uuid/uuid.dart';

import '../models/mission_dto.dart';
import '../redux/actions.dart';
import '../redux/app_state.dart';

class MissionFormScreen extends StatefulWidget {
  final MissionDto? mission;

  const MissionFormScreen({Key? key, this.mission}) : super(key: key);

  @override
  State<MissionFormScreen> createState() => _MissionFormScreenState();
}

class _MissionFormScreenState extends State<MissionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;
  late int _urgency;

  @override
  void initState() {
    super.initState();
    _title = widget.mission?.title ?? '';
    _description = widget.mission?.description ?? '';
    _urgency = widget.mission?.urgency ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.mission == null ? 'Create Mission' : 'Edit Mission')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: const InputDecoration(labelText: 'Title'),
                onSaved: (value) => _title = value ?? '',
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(labelText: 'Description'),
                onSaved: (value) => _description = value ?? '',
              ),
              DropdownButtonFormField<int>(
                value: _urgency,
                decoration: const InputDecoration(labelText: 'Urgency'),
                onChanged: (value) => setState(() => _urgency = value ?? 1),
                items: List.generate(5, (i) => i + 1)
                    .map((level) => DropdownMenuItem(value: level, child: Text(level.toString())))
                    .toList(),
              ),
              const SizedBox(height: 16),
              StoreConnector<AppState, VoidCallback>(
                converter: (store) {
                  return () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final mission = MissionDto(
                        missionGuid: widget.mission?.missionGuid ?? const Uuid().v4(),
                        title: _title,
                        description: _description,
                        status: widget.mission?.status ?? 'Todo',
                        urgency: _urgency,
                      );
                      if (widget.mission == null) {
                        store.dispatch(CreateMission(mission));
                      } else {
                        store.dispatch(UpdateMission(mission));
                      }
                      Navigator.pop(context);
                    }
                  };
                },
                builder: (context, callback) {
                  return ElevatedButton(
                    onPressed: callback,
                    child: const Text('Save'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
