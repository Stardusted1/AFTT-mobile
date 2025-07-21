import 'package:flutter/material.dart';
import "package:redux/redux.dart";
import 'package:flutter_redux/flutter_redux.dart';
import '../redux/actions.dart';
import '../redux/app_state.dart';
import '../widgets/mission_card.dart';
import 'mission_form.dart';

class MissionsListScreen extends StatelessWidget {
  const MissionsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      onInit: (store) => store.dispatch(LoadMissions()),
      converter: (store) => _ViewModel.fromStore(store),
      builder: (context, vm) {
        return Scaffold(
          appBar: AppBar(title: const Text('Missions')),
          body: vm.isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  children: vm.missions
                      .map((m) => MissionCard(mission: m, onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MissionFormScreen(mission: m),
                              ),
                            );
                          }))
                      .toList(),
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const MissionFormScreen(),
              ),
            ),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}

class _ViewModel {
  final List missions;
  final bool isLoading;
  final Function(String) onDelete;

  _ViewModel({required this.missions, required this.isLoading, required this.onDelete});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      missions: store.state.missions,
      isLoading: store.state.isLoading,
      onDelete: (id) => store.dispatch(DeleteMission(id)),
    );
  }
}
