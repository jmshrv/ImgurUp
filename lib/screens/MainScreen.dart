import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        if (MediaQuery.of(context).size.width >
            MediaQuery.of(context).size.height) {
          // If the screen is landscape
          return SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    child: FractionallySizedBox(
                      widthFactor: 0.9,
                      child: FittedBox(
                        child: FloatingActionButton(
                            child: Icon(Icons.camera_alt), onPressed: null),
                      ),
                    ),
                    alignment: Alignment.center,
                  ),
                ),
                Expanded(
                  child: Container(
                    child: FractionallySizedBox(
                      widthFactor: 0.9,
                      child: FittedBox(
                        child: FloatingActionButton(
                            child: Icon(Icons.folder), onPressed: null),
                      ),
                    ),
                    alignment: Alignment.center,
                  ),
                ),
              ],
            ),
          );
        } else {
          // If the screen is portrait
          return SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    child: FractionallySizedBox(
                      heightFactor: 0.9,
                      child: FittedBox(
                        child: FloatingActionButton(
                            child: Icon(Icons.camera_alt), onPressed: null),
                      ),
                    ),
                    alignment: Alignment.center,
                  ),
                ),
                Expanded(
                  child: Container(
                    child: FractionallySizedBox(
                      heightFactor: 0.9,
                      child: FittedBox(
                        child: FloatingActionButton(
                            child: Icon(Icons.folder), onPressed: null),
                      ),
                    ),
                    alignment: Alignment.center,
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
