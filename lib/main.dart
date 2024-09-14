import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'pages/product_list_page.dart';
import 'pages/product_detail_page.dart';
import 'pages/cart_page.dart';
import 'util/cart_provider.dart'; // カート管理用のプロバイダーをインポート

void main() {
  runApp(
    // カートの状態を管理するプロバイダーをアプリ全体で使用
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final GoRouter _router = GoRouter(
    routes: [
      // 商品一覧ページ
      GoRoute(
        path: '/',
        builder: (context, state) => ProductListPage(),
      ),
      // 商品詳細ページ（商品IDをURLパラメータとして受け取る）
      GoRoute(
        path: '/product/:id',
        builder: (context, state) {
          final productId = state.pathParameters['id']; // パラメータ取得
          return ProductDetailPage(productId: productId!);
        },
      ),
      // カートページ
      GoRoute(
        path: '/cart',
        builder: (context, state) => CartPage(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}
