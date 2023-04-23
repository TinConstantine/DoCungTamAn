import 'package:do_cung/information_item.dart';
import 'package:do_cung/modal/item.dart';
import 'package:do_cung/modal/item_recharge.dart';
import 'package:do_cung/modal/item_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:device_preview/device_preview.dart';
import 'package:provider/provider.dart';
import 'const.dart';

import 'drawer.dart';

final itemStorage = AssetItemStorage();

void main() => runApp(ChangeNotifierProvider(
    create: (context) => MyProvider(), child: (const MyApp())));

class MyProvider extends ChangeNotifier {
  List<Item> items = [];
  List<ItemRecharge> recharges = [];
  int sum = 0;
  int balance = 0;
  int priceThisItem = 0;
  List<Item> historyBuy = [];
  String selectValue = "MB Bank";
  void setBalance(int value) {
    balance = value;
    notifyListeners();
  }

  List<ItemRecharge> getRecharges() {
    notifyListeners();
    return recharges;
  }

  void pushRecharges(ItemRecharge recharge) {
    recharges.add(recharge);
    notifyListeners();
  }

  void pushItem(Item item) {
    items.add(item);
    notifyListeners();
  }

  void removeItem(Item item) {
    items.remove(item);
    sum -= int.parse(item.price.toString());
    notifyListeners();
  }

  void totalPrice(int n) {
    sum += n;
    notifyListeners();
  }

  void buyProduct(int n) {
    balance -= n;
    notifyListeners();
  }

  void recharge(int n) {
    balance += n;
    notifyListeners();
  }

  void changeBank(value) {
    selectValue = value;
    notifyListeners();
  }

  void setPriceThisItem(value) {
    priceThisItem = value;
    notifyListeners();
  }

  void pushHistoryBuy(Item item) {
    historyBuy.add(item);
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      useInheritedMediaQuery: true,
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: MyConst.k_colorTheme,
        title: const Text('Đồ cúng Tâm An'),
        centerTitle: true,
      ),
      drawer: const MyDrawer(),
      body: FutureBuilder(
        future: itemStorage.load(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final items = snapshot.data!;
            return MasonryGridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final price = int.parse(item.price.toString());
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => InformationItem(item: item)));
                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                        shape: BoxShape.rectangle,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(item.thumbnail.toString()),
                        ),
                        const SizedBox(height: 8),
                        Text(item.title.toString()),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text('${MyConst.f.format(price)} VNĐ'),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    ));
  }
}
