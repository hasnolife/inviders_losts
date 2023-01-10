import 'package:flutter/material.dart';

class MainListViewWidget extends StatelessWidget {
  const MainListViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      primary: true,
      shrinkWrap: true,
      itemCount: 6,
        itemBuilder: (context, index) {
          return RowListViewWidget();
    });
  }
}

class RowListViewWidget extends StatelessWidget {
  const RowListViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,

        itemCount: 3,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Text('Card $index');
          }
      ),
    );
  }
}
