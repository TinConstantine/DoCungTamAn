import 'package:do_cung/const.dart';
import 'package:do_cung/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

DateTime current_date = DateTime.now();

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
      builder: (context, myProvider, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: MyConst.k_colorTheme,
          title: const Text("Lịch sử mua hàng"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                  child: ListView.builder(
                itemCount: myProvider.historyBuy.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      title:
                          Text(myProvider.historyBuy[index].title.toString()),
                      leading: Image.asset(
                          myProvider.historyBuy[index].thumbnail.toString()),
                      subtitle:
                          Text('-${myProvider.historyBuy[index].price} VNĐ'),
                      trailing: Text(
                        (current_date.toString()),
                      ));
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
