import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:inviders_losts/api_client/api_client.dart';
import 'package:inviders_losts/entity.dart';
import 'package:inviders_losts/resourses/consts.dart';
import 'package:inviders_losts/ui/home_test.dart';

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
            // return MainListViewWidget();
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/bg1.jpg'), fit: BoxFit.cover),
              ),
              child:
              ListView(
                shrinkWrap: true,
                primary: true,
                children: [
                  HeaderDataWidget(
                      title:
                          '${todayData.headline!} станом на ${todayData.todayDate}',
                      date: todayData.todayDate,
                      dayOfWar: DateTime.now()
                          .difference(DateTime(2022, 2, 24))
                          .inDays
                          .toString()),
                  peopleIndex != null
                      ? OneCardWidget(
                          cardData: todayData.data![peopleIndex],
                          index: peopleIndex,
                          iconSize: 2,
                        )
                      : const SizedBox.shrink(),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 6,
                    primary: false,
                    itemBuilder: (context, index) {
                      final OneCardData cardData = todayData.data?[index];

                      return RowCardDataWidget(
                          todayData: todayData, index: index * 2);
                    },

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

class RowCardDataWidget extends StatelessWidget {
  const RowCardDataWidget({
    Key? key,
    required this.todayData,
    required this.index,
  }) : super(key: key);

  final TodayData todayData;
  final int index;

  @override
  Widget build(BuildContext context) {
    final rowCount = MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 4;
    final cardData = todayData.data![index];
    final cardHeight = MediaQuery.of(context).size.height / (todayData.todayDate!.length - 2);
    final cardWidth = MediaQuery.of(context).size.width / rowCount;

    return Container(
      height:  cardHeight,
      child: ListView.builder(

        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: rowCount,
        itemBuilder: (context, rowIndex) {
          return Container(
            width: cardWidth,
            child: OneCardWidget(
                      cardData: todayData.data![index + rowIndex],
                      index: index + rowIndex,
                      iconSize: 1,
                    ),
          );
        },
      ),
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

      child: ListTile(
        style: ListTileStyle.drawer,

        trailing: Text(
          cardData.lostYesterday,
          style: TextStyle(fontSize: screenWidth / 25, color: Colors.red),
          // style: TextStyle(fontSize: screenWidth / 20, color: Colors.red),
        ),
        subtitle: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            cardData.title,
            style: TextStyle(
                fontSize: screenWidth / 28 * iconSize, color: Colors.black),
          ),
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
              style: TextStyle(
                  fontSize: screenWidth / 24 * iconSize, color: Colors.black54),
            ),
          ],
        ),
        // visualDensity: VisualDensity(vertical: 0.5),
      ),
    );
  }
}

class HeaderDataWidget extends StatelessWidget {
  const HeaderDataWidget({
    Key? key,
    required this.title,
    required this.date,
    required this.dayOfWar,
  }) : super(key: key);
  final dayOfWar;
  final title;
  final date;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            dayOfWar,
            style: TextStyle(
                fontSize: height / 14,
                fontWeight: FontWeight.bold,
                color: Colors.yellow[400]),
          ),
          SizedBox(
            width: 15,
          ),
          Column(
            children: [
              Text(
                'ДЕНЬ',
                style: TextStyle(
                    fontSize: height / 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow[400]),
              ),
              Text(
                'ВІЙНИ',
                style: TextStyle(
                    fontSize: height / 33,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow[400]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
