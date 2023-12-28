import 'package:api_using_riverpod/controller/postController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(child: Consumer(builder: (context, ref, child) {
                var postData = ref.watch(postsProvider);
                var loading = ref.watch(loadingDataController);

                return ListView.builder(itemBuilder: (context, index) {
                  return ListTile(
                    leading: loading
                        ? CircularProgressIndicator()
                        : Text(postData![index].id.toString()),
                  );
                });
              }))
            ],
          ),
        ),
      ),
    );
  }

  void init() async {
    try {
      ref.read(loadingDataController.notifier).state = true;
      await ref.read(postsProvider.notifier).getPosts();
      if(mounted) ref.read(loadingDataController.notifier).state = false;
    } catch (e) {
      print("error occured on init");
    }
  }
}
