import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_hive/main.dart';

import '../../../core/utils/constanst.dart';
import 'widgets/fab.dart';
import 'widgets/home_body.dart';
import 'cubit/home_cubit.dart';
import 'cubit/home_state.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(
        this, ModalRoute.of(context)! as PageRoute<dynamic>);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    // Called when the current route has been popped off, and the user has returned to this route.
    context.read<HomeCubit>().loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var textTheme = Theme.of(context).textTheme;
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: GestureDetector(
                  onTap: () async {
                    if (state is HomeLoaded && state.tasks.isEmpty) {
                      warningNoTask(context);
                    } else {
                      await deleteAllTask(context);
                    }
                  },
                  child: const Icon(
                    CupertinoIcons.trash,
                    size: 40,
                  ),
                ),
              )
            ],
          ),
          floatingActionButton: const FAB(),
          body: buildBody(context, state, textTheme),
        );
      },
    );
  }
}
