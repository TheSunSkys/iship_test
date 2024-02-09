import 'dart:io';

import 'package:application_a/components/components.dart';
import 'package:application_a/features/home/bloc/home_bloc.dart';
import 'package:application_a/features/home/view/home_header.dart';
import 'package:application_a/features/login/bloc/login_bloc.dart';
import 'package:application_a/features/login/login.dart';
import 'package:application_a/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Route route() {
    if (Platform.isAndroid) {
      // Android-specific code
      return PageTransition<void>(
        type: PageTransitionType.rightToLeft,
        child: const HomePage(),
      );
    } else {
      // iOS-specific code
      return MaterialPageRoute<void>(
        builder: (_) => const HomePage(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(
        repository: context.read<Repository>(),
      )..add(
          GetOrders(),
        ),
      child: Scaffold(
        key: const Key('HomePage'),
        appBar: HomeHeader(appBar: AppBar()),
        body: BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state.errorCode == '401') {
              context.read<LoginBloc>().add(
                    RemoveToken(),
                  );

              Navigator.pushAndRemoveUntil<void>(
                context,
                LoginPage.route(),
                (route) => false,
              );
            }
          },
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state.status == Status.loading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                );
              }
              return RefreshIndicator(
                color: Colors.black,
                onRefresh: () async {
                  context.read<HomeBloc>().add(
                        GetOrders(),
                      );
                },
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.orders.isEmpty ? 1 : state.orders.length,
                    itemBuilder: (context, index) {
                      if (state.orders.isNotEmpty) {
                        return ComponentsCardOrder(
                          order: state.orders[index],
                        );
                      }

                      return null;
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
