import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../commons/app_bar.dart';
import '../../providers/user_auth/authenticate.dart';
import '../../providers/projects/projects.dart';
import 'projects_body.dart';
import 'projects_app_floating.dart';

class ProjectsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Projects(authToken: context.read<Authenticate>().authToken)),
      ],
      child: ProjectsAppScaffold(),
    );
  }
}

class ProjectsAppScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/backgrounds/projects-bg.png"),
          fit: BoxFit.cover,
        )
      ),
      child: Scaffold(
        appBar: appBar(
          title: '프로젝트',
          trailing: Icon(
            Icons.search,
            color: Colors.black,
          ),
        ),
        body: ProjectsBody(),
        floatingActionButton: ProjectsAppFloating(),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}


