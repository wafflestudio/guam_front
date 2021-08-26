import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../commons/button_size_circular_progress_indicator.dart';

class SaveProfileButton extends StatelessWidget {
  final bool enabled;
  final bool requesting;
  final Function saveProfile;

  SaveProfileButton({
    @required this.enabled,
    @required this.requesting,
    @required this.saveProfile
  });

  @override
  Widget build(BuildContext context) {
    final Gradient gradient = enabled && !requesting ? LinearGradient(
      colors: [HexColor("4F34F3"), HexColor("3EF7FF")],
      begin: FractionalOffset(1.0, 0.0),
      end: FractionalOffset(0.0, 0.0),
      stops: [0, 1],
      tileMode: TileMode.clamp,
    ) : null;

    final Color color = enabled && !requesting ? null : Colors.grey;

    final Widget childWidget = !requesting
        ? saveText() : ButtonSizeCircularProgressIndicator();

    return Container(
      padding: EdgeInsets.fromLTRB(5, 10, 5, 20),
      child: InkWell(
        onTap: enabled && !requesting ? () => saveProfile() : null,
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.85,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(width: 1.5, color: Colors.white24),
            borderRadius: BorderRadius.circular(30),
            gradient: gradient,
            color: color
          ),
          child: childWidget,
        ),
      ),
    );
  }
}

Text saveText() {
  return Text(
    '저장하기',
    style: TextStyle(
      fontSize: 18,
      color: Colors.white,
      fontWeight: FontWeight.bold
    )
  );
}
