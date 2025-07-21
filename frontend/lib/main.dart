import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'redux/app_state.dart';
import 'redux/reducers.dart';
import 'redux/middleware.dart';
import 'screens/missions_list.dart';
import 'app_theme.dart';

void main() {
  final store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: createMiddleware(),
  );

  runApp(AfttApp(store: store));
}

class AfttApp extends StatelessWidget {
  final Store<AppState> store;

  const AfttApp({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'AFTT',
        theme: buildTheme(),
        home: const MissionsListScreen(),
      ),
    );
  }
}
