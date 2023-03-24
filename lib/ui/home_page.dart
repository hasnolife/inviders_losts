import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inviders_losts/bloc/home_page_bloc.dart';
import 'package:inviders_losts/resourses/consts.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomePageBloc>();

    return BlocBuilder(
      bloc: bloc,
      builder: (context, state) {
        if (state is HomePageLoadedState) {
          state.todayDataModel;
          return const HomePageWidget();
        } else if (state is HomePageLoadingErrorState) {
          return _ErrorWidget(errorMessage: state.error.toString());
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
    final bloc = context.read<HomePageBloc>();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errorMessage,
            style: const TextStyle(fontSize: 40),
          ),
          ElevatedButton(
            onPressed: () => bloc.onRefresh(),
            child: const Text('Try Again', style: TextStyle(fontSize: 40)),
          )
        ],
      ),
    );
  }
}

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomePageBloc>();
    final height = MediaQuery.of(context).size.height;
    final cardHeight = MediaQuery.of(context).size.height / (12 / (2) + 2.5);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: height / 12,
          title: const HeaderDataWidget(),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppImages.bdImage), fit: BoxFit.cover),
          ),
          child: RefreshIndicator(
            onRefresh: () => bloc.onRefresh(),
            child: ListView(
              children: [
                SizedBox(
                  height: cardHeight,
                  child: OneCardWidget(
                    index: 12,
                    iconSize: 1,
                    cardHeight: cardHeight,
                  ),
                ),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 6,
                  primary: false,
                  itemBuilder: (context, index) {
                    return RowCardDataWidget(index: index * 2);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RowCardDataWidget extends StatelessWidget {
  const RowCardDataWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final rowCount =
        MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 3;
    final cardHeight =
        MediaQuery.of(context).size.height / (12 / (rowCount) + 2.5);
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
    required this.index,
    required this.iconSize,
    required this.cardHeight,
  }) : super(key: key);

  final int index;
  final double iconSize;
  final double cardHeight;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomePageBloc>();
    final state = bloc.state as HomePageLoadedState;

    final cardData = state.todayDataModel.data[index];
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Card(
      child: AppListTileWidget(
        trailing: Text(
          cardData.lostYesterday,
          style: TextStyle(
            fontSize: cardHeight / 5 / iconSize,
            color: Colors.red,
          ),
        ),
        subtitle: Text(
          cardData.title,
          maxLines: 3,
          softWrap: true,
          style: TextStyle(
              fontSize: cardHeight / 6.2 / iconSize,
              color: Colors.black,
              height: 0.9),
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
              ),
            ),
            Text(
              cardData.losts,
              style: TextStyle(
                  fontSize: cardHeight / 5 / iconSize, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

class AppListTileWidget extends StatelessWidget {
  const AppListTileWidget(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.trailing})
      : super(key: key);

  final Widget title;
  final Widget subtitle;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              title,
              trailing,
            ],
          ),
          subtitle,
        ],
      ),
    );
  }
}

class HeaderDataWidget extends StatelessWidget {
  const HeaderDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.read<HomePageBloc>().state as HomePageLoadedState;
    final todayData = state.todayDataModel;
    final title = todayData.headline;

    final height = MediaQuery.of(context).size.height;
    final direction = MediaQuery.of(context).orientation == Orientation.portrait
        ? Axis.vertical
        : Axis.horizontal;
    return Flex(
      direction: direction,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildDayOfWar(height),
            Text(
              todayData.todayData.toString(),
              style: buildTextStyle(27),
            ),
          ],
        ),
        Text(
          title,
          style: buildTextStyle(16),
        ),
      ],
    );
  }

  Widget buildDayOfWar(double height) {
    final dayOfWar =
        DateTime.now().difference(DateTime(2022, 2, 24)).inDays.toString();
    return Row(
      children: [
        Text(
          dayOfWar,
          style: buildTextStyle(height / 20),
        ),
        const SizedBox(
          width: 15,
        ),
        Column(
          children: [
            Text(
              'ДЕНЬ',
              style: buildTextStyle(height / 50),
            ),
            Text(
              'ВІЙНИ',
              style: buildTextStyle(height / 53),
            ),
          ],
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
