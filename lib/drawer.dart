import 'package:do_cung/history.dart';
import 'package:do_cung/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:do_cung/recharge.dart';
import 'const.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
        builder: (context, myProvider, child) => Drawer(
                child: Column(children: [
              Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  color: MyConst.k_colorTheme,
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage('assets/images/baotri.PNG'),
                                  fit: BoxFit.fill)),
                        ),
                        const Text(
                          "Nguyễn Bá Hiếu",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        const Text(
                          "nghesitin2003@gmail.com",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ],
                    ),
                  )),
              ListTile(
                title:
                    Text("Số dư ${MyConst.f.format(myProvider.balance)} VNĐ"),
              ),
              ListTile(
                leading: const Icon(Icons.person_2),
                title: const Text("Trang cá nhân"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.history),
                title: const Text("Lịch sử mua hàng"),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const History()));
                },
              ),
              ListTile(
                title: const Text('Sản phẩm'),
                leading: const Icon(Icons.shopping_cart),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Bài khấn'),
                leading: const Icon(Icons.document_scanner_outlined),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Nạp tiền'),
                leading: const Icon(Icons.attach_money_outlined),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Recharge(),
                      ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("Đăng xuất"),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ])));
  }
}
