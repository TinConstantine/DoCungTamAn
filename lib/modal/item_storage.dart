import 'package:do_cung/modal/item.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

abstract class ItemStorage {
  Future<List<Item>> load();
}

class AssetItemStorage extends ItemStorage {
  @override
  Future<List<Item>> load() async {
    // await Future.delayed(const Duration(seconds: 2));
    final jsonContent = await rootBundle.loadString("data/data.json");
    final jsonData = jsonDecode(jsonContent) as List<dynamic>;
    return jsonData.map((e) => Item.fromJson(e)).toList();
  }
}
