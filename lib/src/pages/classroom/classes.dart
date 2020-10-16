import 'package:flutter/material.dart';
import 'package:onlineexamplatform/src/pages/classroom/currentexam.dart';
import 'package:onlineexamplatform/src/pages/classroom/previousexam.dart';
import 'package:onlineexamplatform/src/pages/exam/exampage.dart';

class Classes extends StatefulWidget {
  String classname;
  Classes(this.classname);
  //TabController _tabController=new TabController(length: 2,vsync: this);
  @override
  _ClassesState createState() => _ClassesState(classname);
}

class _ClassesState extends State<Classes> with TickerProviderStateMixin {
  String classname;
  _ClassesState(this.classname);
  TabController _tabController;
  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  //_tabController = ;
  int _selectedIndex = 0;
  var pages = [CurrentExam(), PreviousExam()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: Text(classname),
        bottom: TabBar(
          unselectedLabelColor: Colors.white,
          labelColor: Colors.amber,
          tabs: [
            new Tab(
              text: "Current Exam",
            ),
            new Tab(
              text: "Previous Exam",
            ),
          ],
          controller: _tabController,
          //onTap: _onItemTapped,
          indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
        bottomOpacity: 1,
      ),
      body: TabBarView(
        children: [CurrentExam(), PreviousExam()],
        controller: _tabController,
      ),
    );
  }
}
