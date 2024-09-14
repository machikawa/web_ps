import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// 商品データ
final List<Map<String, String>> products = [
  {
    'id': '1',
    'name': 'Product 1',
    'description': 'This is the description for product 1',
    'image':
        'https://image.s4.sfmc-content.com/lib/fe9015747161017476/m/1/0cb56733-902b-417b-ba53-3dcf80a31950.jpg',
    'price': '1980',
  },
  {
    'id': '2',
    'name': 'Product 2',
    'description': 'This is the description for product 2',
    'image':
        'https://image.s4.sfmc-content.com/lib/fe9015747161017476/m/1/cd34f7d1-bd56-455b-8866-7124127e1e13.jpg',
    'price': '2980',
  },
];

// メインテーマカラー
final Color primaryColor = Color(0xFF1A237E); // 深い青色
final Color accentColor = Color(0xFF42A5F5); // アクセントのライトブルー

// 商品一覧ページ
class ProductListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '商品一覧',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            icon: Icon(
              Icons.person_2_rounded,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // 検索バー
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: '商品を検索',
                prefixIcon: Icon(Icons.search, color: accentColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        // 商品詳細ページへ遷移（アニメーション付き）
                        context.go('/product/${product['id']}');
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 6,
                        shadowColor: accentColor,
                        child: ListTile(
                          contentPadding: EdgeInsets.all(16.0),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              product['image']!,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            product['name']!,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['description']!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                '¥${product['price']}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[700],
                                ),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // お気に入りボタン
                              IconButton(
                                icon: Icon(Icons.favorite_border),
                                onPressed: () {},
                                color: accentColor,
                              ),
                              // カート追加ボタン
                              IconButton(
                                icon: Icon(Icons.shopping_cart),
                                onPressed: () {},
                                color: accentColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      // ボトムナビゲーションバー
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: accentColor,
        unselectedItemColor: Colors.grey[600],
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'ホーム',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'お気に入り',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'カート',
          ),
        ],
        onTap: (index) {},
      ),
    );
  }
}
