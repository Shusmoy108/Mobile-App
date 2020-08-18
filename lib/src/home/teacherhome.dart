import 'package:flutter/material.dart';
class TeacherHome extends StatefulWidget {
  String mobile;
  TeacherHome(this.mobile);

  @override
  _TeacherHomeState createState() => _TeacherHomeState(mobile);
}

class _TeacherHomeState extends State<TeacherHome> {
  String mobile;
  _TeacherHomeState(this.mobile);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.teal,
            title: Text("Quiz Master")

        ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    DrawerHeader(
                      child: ListTile(
                        leading: Icon(
                          Icons.account_circle,
                          size: 80,
                        ),
                        title: Text(mobile,
                            style: TextStyle(
                                fontFamily: "ProximaNova",
                                fontSize: 24,
                                fontWeight: FontWeight.w600)),
                        subtitle: Text(mobile,
                            style: TextStyle(
                                fontFamily: "ProximaNova",
                                fontSize: 20,
                                fontWeight: FontWeight.w500)),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.border_color),
                      title: Text(
                        'Exams',
                        style: TextStyle(
                            fontFamily: "ProximaNova",
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      onTap: () {

                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.assignment_turned_in),
                      title: Text(
                        'Results',
                        style: TextStyle(
                            fontFamily: "ProximaNova",
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      onTap: () async {

                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.group),
                      title: Text(
                        'Students',
                        style: TextStyle(
                            fontFamily: "ProximaNova",
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      onTap: () {

                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.insert_chart),
                      title: Text(
                        'Statistics',
                        style: TextStyle(
                            fontFamily: "ProximaNova",
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      onTap: () {

                      },
                    ),
                  ],
                ),
              ),
              Container(
                // This align moves the children to the bottom
                  child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      // This container holds all the children that will be aligned
                      // on the bottom and should not scroll with the above ListView
                      child: Container(
                          child: Column(
                            children: <Widget>[
                              Divider(),

                              ListTile(
                                  leading: Icon(Icons.work),
                                  title: Text('About Us',
                                      style: TextStyle(
                                          fontFamily: "ProximaNova",
                                          fontSize: 18,
                                          fontWeight:
                                          FontWeight.w500))),
                            ],
                          ))))
            ],
          ),
        ),
        body:Container());
  }


}