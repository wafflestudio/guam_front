import 'package:flutter/material.dart';
import 'package:guam_front/screens/projects/search/project_search.dart';
import 'package:provider/provider.dart';
import '../../commons/app_bar.dart';
import '../../providers/user_auth/authenticate.dart';
import '../../providers/projects/projects.dart';
import 'creation/project_create.dart';
import 'creation/project_create_button.dart';
import 'search/project_search.dart';
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
          // IconButton 분리
          leading: ProjectCreateButton(context.watch<Projects>()),
          // IconButton(
          //     icon: Icon(Icons.add),
          //     color: Colors.black,
          //     onPressed: () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) =>
          //                 // ListenableProvider<Projects>.value(
          //                 //   value: context.read<Projects>(),
          //                 //   child: CreateProjectScreen(),
          //                 // )
          //                 CreateProjectScreen(),
          //           ));
          //     }),
          trailing: IconButton(
            icon: Icon(Icons.search),
            color: Colors.black,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchScreen()));
            },
          ),
        ),
        body: ProjectsBody(),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
