import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../util/cart_provider.dart'; // カートプロバイダーをインポート
import 'package:go_router/go_router.dart'; // ルーティングに必要
import 'product_list_page.dart'; // 商品データをインポート

class ProductDetailPage extends StatelessWidget {
  final String productId;

  ProductDetailPage({required this.productId});

  @override
  Widget build(BuildContext context) {
    // 商品データを取得（IDでフィルタリング）
    final product =
        products.firstWhere((product) => product['id'] == productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(product['name']!,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  product['image']!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(product['name']!,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('¥${product['price']}',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green)),
            SizedBox(height: 20),
            Text(product['description']!, style: TextStyle(fontSize: 16)),
            Spacer(),
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                onPressed: () {
                  // Providerを使ってカートに商品を追加
                  Provider.of<CartProvider>(context, listen: false)
                      .addToCart(product);

                  // カート画面に遷移
                  context.go('/cart');
                },
                icon: Icon(Icons.shopping_cart),
                label: Text('カートに追加',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
