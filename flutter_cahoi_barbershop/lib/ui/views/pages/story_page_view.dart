import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/post_tile.dart';

class StoryPageView extends StatefulWidget {
  const StoryPageView({Key? key}) : super(key: key);

  @override
  _StoryPageViewState createState() => _StoryPageViewState();
}

class _StoryPageViewState extends State<StoryPageView> {
  Size size = const Size(0, 0);
  bool like = true;

  @override
  Widget build(BuildContext context) {
    if (size.isEmpty) {
      size = MediaQuery.of(context).size;
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(
              onPressed: () {},
              icon: const Text('Your Story'),
              tooltip: 'Your Story',
            ),
          )
        ],
        title: Image.asset(
          "assets/favicon-ngang.png",
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.error);
          },
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        physics: const BouncingScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) => const PostTile(),
      ),
    );
  }

  // Widget _buildItem() => Card(
  //       elevation: 10.0,
  //       borderOnForeground: true,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //       child: Container(
  //         height: size.height * 0.5,
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(10),
  //         ),
  //         child: Column(
  //           children: [
  //             Expanded(
  //               flex: 3,
  //               child: Container(),
  //             ),
  //             Expanded(
  //               flex: 3,
  //               child: GridView.builder(
  //                 itemCount: 4,
  //                 scrollDirection: Axis.horizontal,
  //                 physics: const BouncingScrollPhysics(),
  //                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //                   crossAxisCount: 1,
  //                 ),
  //                 itemBuilder: (_, index) {
  //                   return Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: Image.network(
  //                       'https://bit.ly/3IVKoIf',
  //                       fit: BoxFit.cover,
  //                     ),
  //                   );
  //                 },
  //               ),
  //             ),
  //             Container(
  //               height: size.height * 0.06,
  //               decoration: const BoxDecoration(
  //                 border: Border(
  //                   top: BorderSide(
  //                     width: 0.5,
  //                     color: Colors.grey,
  //                   ),
  //                 ),
  //               ),
  //               child: Row(
  //                 children: [
  //                   Expanded(
  //                     child: InkWell(
  //                       onTap: () {
  //                         setState(() {
  //                           like = !like;
  //                         });
  //                       },
  //                       child: Center(
  //                         child: Row(
  //                           mainAxisAlignment: MainAxisAlignment.center,
  //                           crossAxisAlignment: CrossAxisAlignment.center,
  //                           children: [
  //                             Image.asset(
  //                               like
  //                                   ? 'assets/ic_like_active.png'
  //                                   : 'assets/ic_like_inactive.png',
  //                               height: 32,
  //                             ),
  //                             const Padding(
  //                               padding: EdgeInsets.all(8.0),
  //                               child: Text(
  //                                 '400',
  //                                 style: TextStyle(fontSize: 16),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   Container(
  //                     width: 0.5,
  //                     height: double.infinity,
  //                     decoration: const BoxDecoration(
  //                       color: Colors.grey,
  //                     ),
  //                   ),
  //                   Expanded(
  //                     child: InkWell(
  //                       onTap: () {},
  //                       child: Center(
  //                         child: Row(
  //                           mainAxisAlignment: MainAxisAlignment.center,
  //                           crossAxisAlignment: CrossAxisAlignment.center,
  //                           children: [
  //                             Image.asset(
  //                               'assets/dislike_active.png',
  //                               height: 32,
  //                             ),
  //                             const Padding(
  //                               padding: EdgeInsets.all(8.0),
  //                               child: Text(
  //                                 '4',
  //                                 style: TextStyle(fontSize: 16),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
}
