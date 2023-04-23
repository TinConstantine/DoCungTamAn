import 'package:do_cung/main.dart';
import 'package:do_cung/modal/item_recharge.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'const.dart';

// ignore: non_constant_identifier_names
DateTime current_date = DateTime.now();

// ignore: must_be_immutable
class Recharge extends StatelessWidget {
  Recharge({super.key});
  final controller = TextEditingController();
  final controllerId = TextEditingController();
  final controllerCardName = TextEditingController();
  List<String> banks = [
    "MB Bank",
    "TP Bank",
    "Techcombank",
    "BIDV",
    "ACB ",
    "VIB",
    "Agribank"
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
        builder: (context, myProvider, child) => Scaffold(
              appBar: AppBar(
                backgroundColor: MyConst.k_colorTheme,
                title: const Text("Nạp tiền"),
                centerTitle: true,
              ),
              body: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    Flexible(
                        child: TextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'\s')),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                      controller: controller,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Nhập số tiền muốn nạp"),
                    )),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text("Chọn ngân hàng"),
                          Flexible(
                            child: DropdownButton<String>(
                              value: myProvider.selectValue,
                              icon: const Icon(Icons.arrow_downward),
                              elevation: 10,
                              onChanged: (String? value) {
                                myProvider.changeBank(value);
                              },
                              items: banks.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Flexible(
                        child: TextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'\s')),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                      controller: controllerId,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Nhập số thẻ"),
                    )),
                    const SizedBox(
                      height: 10,
                    ),
                    Flexible(
                        child: TextField(
                      controller: controllerCardName,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Nhập tên in trên thẻ"),
                    )),
                    const SizedBox(
                      height: 10,
                    ),
                    Flexible(
                      flex: 1,
                      child: ElevatedButton(
                          style: const ButtonStyle(
                              minimumSize:
                                  MaterialStatePropertyAll(Size(200, 50))),
                          onPressed: () {
                            if (controller.text.isEmpty ||
                                controllerCardName.text.isEmpty ||
                                controllerId.text.isEmpty ||
                                int.parse(controller.text.toString()) == 0) {
                              const snackBar = SnackBar(
                                content: Text(
                                    'Vui lòng điền đủ các trường thông tin'),
                                duration: Duration(milliseconds: 500),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              myProvider.pushRecharges(ItemRecharge(
                                  time: current_date.toString(),
                                  money: controller.text));
                              myProvider.setBalance(int.parse(controller.text));
                              controller.clear();
                              controllerCardName.clear();
                              controllerId.clear();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const Success()));
                            }
                          },
                          child: const Text("Nạp tiền")),
                    ),
                    const Spacer(),
                    Flexible(
                        flex: 6,
                        child: ListView.builder(
                            itemCount: myProvider.recharges.length,
                            itemBuilder: (context, index) {
                              final recharge = myProvider.recharges[index];
                              return Card(
                                child: ListTile(
                                  title: Text(
                                      "${MyConst.f.format(int.parse(recharge.money))}VNĐ"),
                                  subtitle: Text(recharge.time),
                                  trailing: const Text("Thành công"),
                                ),
                              );
                            }))
                  ],
                ),
              ),
            ));
  }
}

class Success extends StatelessWidget {
  const Success({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Thông báo'),
      content: const Text(
          "Giao dịch thành công, vui lòng kiểm tra tài khoản của bạn"),
      actions: <Widget>[
        TextButton(
          child: const Text('Đồng ý'),
          onPressed: () {
            // Xử lý khi người dùng ấn vào nút đồng ý
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
