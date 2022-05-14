import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/models/post.dart';
import 'package:flutter_cahoi_barbershop/core/models/screen_arguments.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/post_tile.dart';
import 'package:fluttertoast/fluttertoast.dart';

class YourStoryView extends StatefulWidget {
  const YourStoryView({Key? key}) : super(key: key);

  @override
  State<YourStoryView> createState() => _YourStoryViewState();
}

class _YourStoryViewState extends State<YourStoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) => PostTile(
            post: Post.initial(),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
