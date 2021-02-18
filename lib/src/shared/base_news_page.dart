import 'package:comparing_getters/src/shared/pages_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


abstract class BaseNewsPage extends StatelessWidget {
  final String pageId;
  /* ---------------------------------------------------------------------------- */
  const BaseNewsPage({Key key, @required this.pageId}) : super(key: key);
  /* ---------------------------------------------------------------------------- */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kPagesInfo[pageId]['header']),
        // centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          children: List<Widget>.generate(
            kPagesInfo.length, 
            (index) => _buildMenuItem(kPagesInfo.keys.toList()[index]),
          ),
        ),
      ),
      body: buildBody(),
    );
  }
  /* ---------------------------------------------------------------------------- */
  Widget buildBody();
  /* ---------------------------------------------------------------------------- */
  ListTile _buildMenuItem(String keyword) {
    return ListTile(
      title: Text(kPagesInfo[keyword]['header']),
      onTap: () => Get.toNamed(kPagesInfo[keyword]['path']),
      leading: Icon(kPagesInfo[keyword]['icon']),
      selected: keyword == pageId,
      selectedTileColor: Colors.redAccent[100],
    );
  }
}
