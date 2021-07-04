import 'package:flutter/material.dart';
import 'package:guam_front/providers/stacks/stacks.dart';
import 'package:guam_front/screens/projects/search/project_search_button.dart';
import 'package:provider/provider.dart';
import '../../commons/app_bar.dart';
import '../../providers/user_auth/authenticate.dart';
import '../../providers/projects/projects.dart';
import 'creation/project_create.dart';
import 'projects_body.dart';

class ProjectsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProxyProvider<Authenticate, Projects>(
          create: (_) => Projects(),
          update: (_, authProvider, projectsProvider) =>
              projectsProvider..authProvider = authProvider,
        ),
        ChangeNotifierProvider<Stacks>(
          create: (_) => Stacks(),
        )
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
      )),
      child: Scaffold(
        appBar: appBar(
            title: '프로젝트',
            leading: IconButton(
                icon: Icon(Icons.add),
                color: Colors.black,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateProjectScreen()));
                }),
            trailing: ProjectSearchButton(
                context.read<Stacks>(), context.watch<Projects>())),
        body: ProjectsBody(),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
