import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:inviders_losts/api_client/api_client.dart';
import 'package:inviders_losts/entity.dart';
import 'package:inviders_losts/resourses/consts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final Future<TodayData> data;

  @override
  void initState() {
    data = ApiClient().getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final todayData = snapshot.data as TodayData;
            final gridLength = (todayData.data!.length % 2 != 0)
                ? todayData.data!.length - 1
                : todayData.data!.length;
            final peopleIndex = (todayData.data!.length % 2 != 0)
                ? todayData.data!.length - 1
                : null;

            return Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/bg1.jpg'),
                  fit: BoxFit.fitHeight
                ),
              ),
              child: ListView(
                shrinkWrap: true,
                primary: true,

                children: [

                  peopleIndex != null
                      ? OneCardWidget(
                          cardData: todayData.data![peopleIndex],
                          index: 12,
                          iconSize: 2,
                        )
                      : SizedBox.shrink(),
                  ListView.builder(

                    shrinkWrap: true,
                    itemCount: 6,
                    primary: false,
                    itemBuilder: (context, index) {
                      final OneCardData cardData = todayData.data?[index];
                      return CardDataWidget(
                          todayData: todayData, index: index * 2);
                    },
                    // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //   crossAxisCount: (MediaQuery.of(context).orientation ==
                    //           Orientation.portrait
                    //       ? 2
                    //       : 3),
                    // ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
                child: Text(
              "Error",
              style: TextStyle(fontSize: 40),
            ));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class CardDataWidget extends StatelessWidget {
  const CardDataWidget({
    Key? key,
    required this.todayData,
    required this.index,
  }) : super(key: key);

  final TodayData todayData;
  final int index;

  @override
  Widget build(BuildContext context) {
    final cardData = todayData.data![index];
    return Row(
      children: [
        Expanded(
            child: OneCardWidget(
          cardData: todayData.data![index],
          index: index,
          iconSize: 1,
        )),
        Expanded(
          child: OneCardWidget(
            cardData: todayData.data![index + 1],
            index: index + 1,
            iconSize: 1,
          ),
        ),
      ],
    );
  }
}

class OneCardWidget extends StatelessWidget {
  const OneCardWidget({
    Key? key,
    required this.cardData,
    required this.index,
    required this.iconSize,
  }) : super(key: key);

  final OneCardData cardData;
  final int index;
  final iconSize;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Card(
      // child: CustomListTileWidget(
      //   cardData: cardData,
      //   index: index,
      child: ListTile(
        style: ListTileStyle.drawer,
        leading: null,

        trailing: Text(
          cardData.lostYesterday,
          style: TextStyle(fontSize: screenWidth / 20, color: Colors.red),
        ),
        subtitle: Text(
          cardData.title,
          style: TextStyle(fontSize: screenWidth / 26 * iconSize,color: Colors.black),
        ),
        title: Row(
          children: [
            SizedBox(
              width: screenWidth / 6 * iconSize,
              height: screenHeight / 14,
              child: Image.asset(
                icons[index],
                width: screenWidth / 6 * iconSize,
                height: screenHeight / 14 * iconSize,
                fit: BoxFit.fitWidth,
                color: Colors.black54,
                // alignment: Alignment.center,
              ),
            ),
            Text(
              cardData.losts,
              style: TextStyle(fontSize: screenWidth / 24 * iconSize, color: Colors.black54),
            ),
          ],
        ),
        // visualDensity: VisualDensity(vertical: 0.5),
      ),
    );
  }
}
