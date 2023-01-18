import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'domain/domain_providers.dart';
import 'firebase_options.dart';
import 'infrastructure/firebase/firebase_providers.dart';
import 'infrastructure/firebase/posts/post_repository.dart';
import 'presentation/views/time_line_page.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ProviderScope(
      overrides: [
        // 各プロバイダーをoverrideする
        postRepositoryProvider.overrideWith((ref) {
          final repository = FirebasePostRepository(
            collectionRef: ref.watch(postsCollectionRefProvider),
          );
          return repository;
        })
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'riverpod-layered-architecture',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      //タイムラインページを表示
      home: const TimeLinePage(),
    );
  }
}
