import 'package:flutter/material.dart';

class Success extends StatelessWidget {
  const Success({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Thông báo'),
      content: const Text("Giao dịch thành công"),
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

class Failed extends StatelessWidget {
  const Failed({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Thông báo'),
      content: const Text("Giao dịch thất bại, vui lòng nạp thêm "),
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
