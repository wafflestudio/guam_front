import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../providers/home/home_provider.dart';
import '../../providers/user_auth/authenticate.dart';
import '../home/home.dart';

class Auth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
          future: _initFirebaseApp(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              context.read<Authenticate>(); // Initialization of user authentication

              return ChangeNotifierProvider(
                create: (_) => HomeProvider(),
                child: Home(),
              );
            } else {
              return Center(
                child: SvgPicture.asset('assets/logos/guam_logo.svg', color: HexColor('#6200EE')),
              );
            }
          },
        )
    );
  }

  Future<FirebaseApp> _initFirebaseApp() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }
}

