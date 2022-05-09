import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ListHistory extends StatefulWidget {
  const ListHistory({Key? key}) : super(key: key);

  @override
  State<ListHistory> createState() => _ListHistoryState();
}

class _ListHistoryState extends State<ListHistory> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      physics: const BouncingScrollPhysics(parent: ClampingScrollPhysics()),
      itemCount: 10,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return const HistoryTile();
      },
    );
  }
}

class HistoryTile extends StatefulWidget {
  const HistoryTile({Key? key}) : super(key: key);

  @override
  State<HistoryTile> createState() => _HistoryTileState();
}

class _HistoryTileState extends State<HistoryTile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: size.width * 0.85,
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCoupleText(first: 'Time: ', last: "20:00"),
                    _buildCoupleText(first: 'Date: ', last: "2022-05-09"),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  'Rating Skill: ',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Expanded(
                                child: RatingBarIndicator(
                                  rating: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemCount: 5,
                                  itemSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  'Rating Communication: ',
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                              Expanded(
                                child: RatingBarIndicator(
                                  rating: 4,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemCount: 5,
                                  itemSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                          _buildCoupleText(
                            first: "Stylist: ",
                            last: "Lequang thọ",
                          ),
                          _buildCoupleText(
                            first: "Facility: ",
                            last: "320 Cau Giay",
                          )
                        ],
                      ),
                    ),
                    _getStatus(true)
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Image.asset('assets/logo.jpg'),
                    ),
                    const SizedBox(
                      width: 4.0,
                    ),
                    Expanded(
                      child: Image.asset('assets/logo.jpg'),
                    ),
                    const SizedBox(
                      width: 4.0,
                    ),
                    Expanded(
                      child: Image.asset('assets/logo.jpg'),
                    ),
                    const SizedBox(
                      width: 4.0,
                    ),
                    Expanded(
                      child: Image.asset('assets/logo.jpg'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              child: const Icon(
                                Icons.share,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              child: const Icon(
                                Icons.share,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Delete All Image',
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCoupleText({required String first, required String last}) {
    return RichText(
      text: TextSpan(
        text: first,
        style: const TextStyle(
          color: Colors.black,
        ),
        children: [
          TextSpan(
            text: last,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: fontBold,
            ),
          )
        ],
      ),
    );
  }

  _getStatus(bool status) {
    return Column(
      children: const [
        Icon(
          Icons.check_circle,
          color: Colors.green,
        ),
        Text(
          'Successful',
        )
      ],
    );
  }
}
