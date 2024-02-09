import 'package:application_a/features/home/view/home_page.dart';
import 'package:application_a/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'features/login/bloc/login_bloc.dart';
import 'features/login/view/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

  runApp(
    MyApp(
      repository: Repository(
        uri: 'https://app-uat.iship.cloud',
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.repository,
  });

  final Repository repository;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: repository,
      child: BlocProvider(
        create: (_) => LoginBloc(
          repository: repository,
        ),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primaryColor: Colors.black,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.black,
              primary: Colors.black
            ),
            useMaterial3: true,
          ),
          home: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state.token != '') {
                return const HomePage();
              }

              return const LoginPage();
            },
          ),
        ),
      ),
    );
  }
}
