import 'package:do_cung/main.dart';
import 'package:do_cung/modal/item.dart';
import 'package:do_cung/shopping_cart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'alert.dart';
import 'const.dart';

final f = NumberFormat("###,###.###", "tr_TR");

// ignore: must_be_immutable
class InformationItem extends StatelessWidget {
  Item item;
  InformationItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final size = MediaQuery.of(context).size;
    return Consumer<MyProvider>(
        builder: (context, myProvider, child) => Scaffold(
              appBar: AppBar(
                backgroundColor: MyConst.k_colorTheme,
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ShoppingCart(),
                            ));
                      },
                      icon: const Icon(Icons.shopping_cart))
                ],
              ),
              body: Column(children: [
                const Padding(padding: EdgeInsets.all(10)),
                Flexible(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(item.thumbnail.toString()))),
                Text(item.title.toString()),
                Text("Giá: ${f.format(int.parse(item.price.toString()))} VNĐ"),
                Expanded(
                    child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: item.meaning!.length,
                  itemBuilder: (context, index) {
                    return Text(item.meaning![index]);
                  },
                )),
                const Text("Nguyên liệu gồm những gì"),
                Expanded(
                    child: ListView.builder(
                  // padding: const EdgeInsets.all(10),
                  itemCount: item.ingredient!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Text("${index + 1}"),
                      title: Text(item.ingredient![index]),
                    );
                  },
                )),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        onTap: () {
                          myProvider.pushItem(item);
                          myProvider
                              .totalPrice(int.parse(item.price.toString()));
                          const snackBar = SnackBar(
                            content: Text('Thêm thành công'),
                            duration: Duration(milliseconds: 500),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        title: const Center(
                          child: Icon(Icons.add_shopping_cart),
                        ),
                        subtitle:
                            const Center(child: Text("Thêm vào giỏ hàng")),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        onTap: () {
                          myProvider.setPriceThisItem(
                              int.parse(item.price.toString()));
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const ListTile(
                                      leading: Icon(Icons.list_alt_outlined),
                                      title: Text("Chi tiết hóa đơn"),
                                    ),
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
                                            ('${myProvider.priceThisItem} VNĐ'))
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Còn lại"),
                                        Text(
                                            "${myProvider.balance - myProvider.sum}")
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
                                                    myProvider
                                                        .pushHistoryBuy(item);
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
                        title: const Center(
                          child: Icon(Icons.attach_money_outlined),
                        ),
                        subtitle: const Center(child: Text("Mua ngay")),
                      ),
                    ),
                  ],
                )
              ]),

              // ListView.builder(
              //     itemCount: item.ingredient!.length,
              //     itemBuilder: (context, index) {
              //       return Text(item.ingredient![index].toString());
              //     })
            ));
  }
}
