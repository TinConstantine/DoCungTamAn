import 'package:do_cung/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'const.dart';
import 'alert.dart';

// ignore: must_be_immutable
class ShoppingCart extends StatelessWidget {
  const ShoppingCart({super.key});

  @override
  Widget build(BuildContext context) {
    dynamic sum = 0;
    return Consumer<MyProvider>(
      builder: (context, myProvider, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: MyConst.k_colorTheme,
          title: const Text("Giỏ hàng"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              flex: 12,
              child: ListView.builder(
                  itemCount: myProvider.items.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                      blurRadius: 1.0,
                                      spreadRadius: 1.0,
                                      color: Colors.grey)
                                ]),
                            child: ListTile(
                              title: Text(
                                  myProvider.items[index].title.toString()),
                              subtitle: Text(
                                  '${MyConst.f.format(int.parse(myProvider.items[index].price.toString()))} VNĐ'),
                              leading: Image.asset(
                                  myProvider.items[index].thumbnail.toString()),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  myProvider
                                      .removeItem(myProvider.items[index]);
                                  const snackBar = SnackBar(
                                    content: Text('Xóa thành công'),
                                    duration: Duration(milliseconds: 500),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                },
                              ),
                            )));
                  }),
            ),
            const Padding(padding: EdgeInsets.all(3)),
            Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Text("Thành tiền: ${MyConst.f.format(myProvider.sum)} VNĐ"),
                    ElevatedButton(
                        onPressed: () {
                          showModalBottomSheet<void>(
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Align(
                                        alignment: Alignment.center,
                                        child: ListTile(
                                          leading:
                                              Icon(Icons.list_alt_outlined),
                                          title: Text("Chi tiết hóa đơn"),
                                        )),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Số dư"),
                                        Text(myProvider.balance.toString())
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Thành tiền"),
                                        Text(
                                            '${MyConst.f.format(myProvider.sum)} VNĐ')
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Còn lại"),
                                        Text(MyConst.f.format(
                                            myProvider.balance -
                                                myProvider.sum))
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: ElevatedButton(
                                                style: const ButtonStyle(
                                                    minimumSize:
                                                        MaterialStatePropertyAll(
                                                            Size(200, 50))),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Hủy"))),
                                        const Padding(
                                            padding: EdgeInsets.only(left: 10)),
                                        Expanded(
                                            child: ElevatedButton(
                                                style: const ButtonStyle(
                                                    minimumSize:
                                                        MaterialStatePropertyAll(
                                                            Size(200, 50))),
                                                onPressed: () {
                                                  if (myProvider.balance -
                                                          myProvider.sum >
                                                      0) {
                                                    myProvider.items
                                                        .map((e) => myProvider
                                                            .pushHistoryBuy(e))
                                                        .toList();
                                                    myProvider.items.clear();
                                                    myProvider.buyProduct(
                                                        myProvider.sum);
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (_) =>
                                                              const Success(),
                                                        ));
                                                  } else {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                const Failed()));
                                                  }
                                                },
                                                child:
                                                    const Text("Thanh toán")))
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: const Text("Thanh toán"))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
