import 'package:flutter/material.dart';

class AchievementPage extends StatefulWidget {
  @override
  _AchievementState createState() => _AchievementState();
}

class _AchievementState extends State<AchievementPage> {
  int x = 0;
  Widget achieve(int i) {
    x = (2 * (i - 1)) + 1;
    String level = "Give " + x.toString() + " exams to complete the level";
    String trail = "0/" + x.toString();

    return Center(
      child: Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            print('Card tapped.');
          },
          child: ListTile(
            leading: Text(
              i.toString(),
              style: TextStyle(fontSize: 20),
            ),
            title: Text(level),
            subtitle: LinearProgressIndicator(
              backgroundColor: Colors.red,
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.teal),
              value: 0.4,
            ),
            trailing: Text(trail),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(itemBuilder: (context, index) {
        return achieve(index + 1);
      }),
    );
  }
}
