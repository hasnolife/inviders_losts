import 'package:flutter/material.dart';
import 'package:inviders_losts/api_client/api_client.dart';
import 'package:inviders_losts/entity.dart';

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

            return ListView.builder(
              itemCount: todayData.data?.length,
              itemBuilder: (context, index) {
                final OneCardData cardData = todayData.data?[index];
                return CardDataWidget(cardData: cardData);
              },
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
    required this.cardData,
  }) : super(key: key);

  final OneCardData cardData;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        trailing: Text(cardData.lostYesterday),
        subtitle: Text(cardData.losts),
        title: Text(cardData.title),
      ),
    );
  }
}
