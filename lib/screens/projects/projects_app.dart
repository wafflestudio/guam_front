import 'package:flutter/material.dart';
import 'package:guam_front/screens/projects/search/project_search_button.dart';
import 'package:provider/provider.dart';

import '../../commons/custom_app_bar.dart';
import '../../providers/projects/projects.dart';
import '../../providers/user_auth/authenticate.dart';
import '../tutorial/tutorial_modal.dart';
import 'creation/project_create_button.dart';
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
      ],
      child: TutorialModal(),
      // child: ProjectsAppScaffold(),
    );
  }
}

class ProjectsAppScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          image: DecorationImage(
        colorFilter:
            ColorFilter.mode(Colors.white.withOpacity(0.6), BlendMode.dstATop),
        image: AssetImage("assets/backgrounds/projects-bg-2.png"),
        fit: BoxFit.cover,
      )),
      child: Scaffold(
        appBar: CustomAppBar(
            title: '프로젝트',
            leading: ProjectCreateButton(),
            trailing: ProjectSearchButton()
        ),
        body: ProjectsBody(),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
