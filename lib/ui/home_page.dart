import 'package:flutter/material.dart';
import 'package:inviders_losts/ui/home_page_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:inviders_losts/entity.dart';
import 'package:inviders_losts/resourses/consts.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<HomePageModel>();
    final futureData = model.futureData;

    return FutureBuilder(
      future: futureData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const HomePageWidget();
        } else if (snapshot.hasError) {
          return _ErrorWidget(errorMessage: snapshot.error.toString());
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  final String errorMessage;

  const _ErrorWidget({Key? key, required this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      "Error $errorMessage",
      style: const TextStyle(fontSize: 40),
    ));
  }
}

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(context),
        body: buildScaffoldBody(context),
      ),
    );
  }

  Container buildScaffoldBody(BuildContext context) {
    final model = context.watch<HomePageModel>();
    final rowCount =
        MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 3;
    final todayData = model.data;
    final gridLength = (todayData.data!.length % 2 != 0)
        ? todayData.data!.length - 1
        : todayData.data!.length;
    final peopleIndex =
        (todayData.data!.length % 2 != 0) ? todayData.data!.length - 1 : null;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final portraitHeight = MediaQuery.of(context).size.height / (12 / (rowCount) + 2.5);
    final albumHeight = height / 6;
    return Container(
     decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(AppImages.bdImage), fit: BoxFit.cover),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final cardHeight =
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? portraitHeight
                  : albumHeight;
          return RefreshIndicator(
            onRefresh: () => model.onRefresh(context),
            child: ListView(
              children: [
                peopleIndex != null
                    ? SizedBox(
                        height: cardHeight,
                        child: OneCardWidget(
                          cardData: todayData.data![peopleIndex],
                          index: peopleIndex,
                          iconSize: 2 / rowCount,
                          cardHeight: cardHeight,
                        ),
                      )
                    : const SizedBox.shrink(),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: (gridLength ~/ rowCount),
                  primary: false,
                  itemBuilder: (context, index) {
                    // final OneCardData cardData = todayData.data?[index];

                    return RowCardDataWidget(
                        todayData: todayData, index: index * rowCount);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    final todayData = context.read<HomePageModel>().data;
    return AppBar(
      title: FittedBox(
        fit: BoxFit.fitHeight,
        child: HeaderDataWidget(),
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
    final rowCount =
        MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 3;
    // final cardData = todayData.data![index];
    final cardHeight = MediaQuery.of(context).size.height / (12 / (rowCount) + 2.5);
    final cardWidth = MediaQuery.of(context).size.width / (rowCount);

    return SizedBox(
      height: cardHeight,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: rowCount,
        itemBuilder: (context, rowIndex) {
          return SizedBox(
            width: cardWidth,
            child: OneCardWidget(
              cardData: todayData.data![index + rowIndex],
              index: index + rowIndex,
              iconSize: 2 / rowCount,
              cardHeight: cardHeight,
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
    required this.cardHeight,
  }) : super(key: key);

  final OneCardData cardData;
  final int index;
  final double iconSize;
  final double cardHeight;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Card(
      child: ListTile(
        style: ListTileStyle.drawer,

        trailing: Text(
          cardData.lostYesterday,
          style:
              TextStyle(fontSize: cardHeight / 7 / iconSize, color: Colors.red),
          // style: TextStyle(fontSize: screenWidth / 20, color: Colors.red),
        ),
        subtitle: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.bottomLeft,
          child: Text(
            cardData.title,
            style: TextStyle(
                fontSize: cardHeight / 6 / iconSize, color: Colors.black),
          ),
        ),
        title: Row(
          children: [
            SizedBox(
              width: screenWidth / 7 * iconSize,
              // height: screenHeight / 14,
              height: cardHeight / 2.5,
              child: Image.asset(
                AppImages.icons[index],
                width: screenWidth / 7 * iconSize,
                height: screenHeight / 15 * iconSize,
                fit: BoxFit.contain,
                color: Colors.black54,

                // alignment: Alignment.center,
              ),
            ),
            Text(
              cardData.losts,
              style: TextStyle(
                  fontSize: cardHeight / 6 / iconSize, color: Colors.black54),
            ),
          ],
        ),
        // visualDensity: VisualDensity(vertical: 0.5),
      ),
    );
  }
}

class HeaderDataWidget extends StatelessWidget {
  const HeaderDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<HomePageModel>();
    final todayData = model.data;
    final title = '${todayData.headline!} станом на ${todayData.todayDate}';
    final dayOfWar =
        DateTime.now().difference(DateTime(2022, 2, 24)).inDays.toString();
    final height = MediaQuery.of(context).size.height;
    final direction = MediaQuery.of(context).orientation == Orientation.portrait
        ? Axis.vertical
        : Axis.horizontal;
    return Flex(
      direction: direction,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              dayOfWar,
              style: buildTextStyle(height / 14),
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              children: [
                Text(
                  'ДЕНЬ',
                  style: buildTextStyle(height / 30),
                ),
                Text(
                  'ВІЙНИ',
                  style: buildTextStyle(height / 33),
                ),
              ],
            ),
          ],
        ),
        Container(
          // height: height,
          // padding: EdgeInsets.all(10),
          alignment: Alignment.bottomCenter,
          child: Text(
            title,
            style: buildTextStyle(25),
          ),
        ),
      ],
    );
  }

  TextStyle buildTextStyle(double fontSize) {
    return TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: Colors.yellow[400]);
  }
}
