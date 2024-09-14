import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../util/cart_provider.dart'; // カートプロバイダーをインポート
import 'package:go_router/go_router.dart'; // 商品一覧に戻るためのルーティング

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('カート',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // カートが空のときの処理
            if (cart.cartItems.isEmpty) ...[
              Expanded(
                child: Center(
                  child: Text(
                    'カートに商品がありません',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                onPressed: () {
                  // 商品一覧に戻る
                  context.go('/');
                },
                icon: Icon(Icons.arrow_back),
                label: Text(
                  '商品一覧に戻る',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ] else ...[
              // カートに商品がある場合の処理
              Expanded(
                child: ListView.builder(
                  itemCount: cart.cartItems.length,
                  itemBuilder: (context, index) {
                    final product = cart.cartItems[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 4,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            product['image']!,
                            width: 50, // 画像の幅を指定
                            height: 50, // 画像の高さを指定
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(product['name']!,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        subtitle: Text('¥${product['price']}',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green)),
                        // ゴミ箱ボタン追加
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            // 削除確認ダイアログ表示
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('削除確認'),
                                content: Text('この商品をカートから削除しますか？'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // ダイアログを閉じる
                                    },
                                    child: Text('キャンセル'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // 商品をカートから削除
                                      cart.removeFromCart(product);
                                      Navigator.of(context).pop(); // ダイアログを閉じる
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                onPressed: () {
                  // 購入完了のダイアログ表示
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('購入完了'),
                      content: Text('購入が完了しました！'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            cart.clearCart(); // カートをクリア
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                icon: Icon(Icons.payment),
                label: Text('購入する',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 20),
            ],
          ],
        ),
      ),
    );
  }
}
