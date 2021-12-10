import 'package:flutter/material.dart';
import 'package:flutter_architecture_business/flutter_architecture_business.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final MainBloc _mainBloc;
  @override
  void initState() {
    super.initState();
    _mainBloc = GetIt.I.get<MainBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<MainBloc>(
      create: (_) => _mainBloc,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo'),
      ),
      body: StreamBuilder<MainBlocState>(
        stream: context.read<MainBloc>().state,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final state = snapshot.data;
            return state!.map(
              loading: (_) => const Center(
                child: Text('Initializing'),
              ),
              loaded: (state) => Scaffold(
                body: Center(
                  child: Text(
                    state.userData.name,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () => context.read<MainBloc>().add(
                        MainBlocEvent.setUser(
                          userId: state.userData.id + 1,
                        ),
                      ),
                ),
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
