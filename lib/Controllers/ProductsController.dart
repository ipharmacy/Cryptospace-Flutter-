import 'dart:convert';

import 'package:flutter_universe/Models/Product.dart';
import 'package:flutter_universe/staticdata/constants.dart';
import 'package:http/http.dart';

class ProductsController {
  Future<List<Product>>getProducts() async{
    final response = await get(
      Uri.http(baseURL,"api/products/")
    );
    if(response.statusCode==200){
      var jsonData = json.decode(response.body);
      List<Product> products = [];

      for(var p in jsonData){
        Product product = Product.fromJson(p);
        print(product);
        products.add(product);
      }
      return products;
    }else{
      throw Exception('Request API Failed');
    }
  }

  Future<Product>getProduct(String id) async{
    final response = await post(
      Uri.http(baseURL,"api/products/id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'productId': id,
      }),
    );
    if(response.statusCode==200){
      var jsonData = json.decode(response.body);
        Product product = Product.fromJson(jsonData);
      return product;
    }else{
      throw Exception('Request API Failed');
    }
  }

}