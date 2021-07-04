import 'package:book_now/provider/my_project.dart';
import 'package:book_now/style/main_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateProjectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myProjectRead = context.read<MyProjectProvider>();
    final myProjectWatch = context.watch<MyProjectProvider>();

    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text("Create Project"),
      ),
      body: FutureBuilder(
        future: myProjectRead.getData().then((val) {
          if (val == "error") {}
        }),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
              child: Container(
                width: MediaQuery.of(context).size.width / 1.1,
                height: MediaQuery.of(context).size.height / 1.5,
                child: Card(
                  elevation: 20,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: myProjectWatch.tabsWidget[myProjectWatch.tabIndex],
                  ),
                ),
              ),
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 20,
        onTap: (val) {
          myProjectRead.changeTabIndex(val);
        },
        currentIndex: myProjectWatch.tabIndex,
        unselectedFontSize: 15,
        type: BottomNavigationBarType.fixed,
        backgroundColor: mainColor,
        fixedColor: Colors.black,
        unselectedItemColor: Colors.brown,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.create),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.select_all),
            label: 'Select',
          ),
        ],
      ),
    );
  }
}
