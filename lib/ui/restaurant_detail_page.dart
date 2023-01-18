import 'package:bfaf_submission2/data/model/restaurant_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/model/restaurant_detail.dart';
import '../provider/restaurant_detail_provider.dart';
import '../utils/result_state.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/resto_detail';

  final String restoId;

  const RestaurantDetailPage({Key? key, required this.restoId})
      : super(key: key);

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  @override
  void initState() {
    Future.microtask(() {
      RestaurantDetailProvider provider = Provider.of<RestaurantDetailProvider>(
        context,
        listen: false,
      );
      provider.fetchRestaurantDetail(widget.restoId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildDetail();
  }

  Widget _buildDetail() {
    return Scaffold(
      body: Consumer<RestaurantDetailProvider>(
        builder: (context, provider, _) {
          ResultState<RestaurantDetail> state = provider.state;
          switch (state.status) {
            case StatusState.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case StatusState.noData:
              return const Center(
                child: Text('Empty Data'),
              );
            case StatusState.hasData:
              RestaurantListElement restaurant = state.data!.restaurant;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Hero(
                          tag: restaurant.pictureId,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(14.0),
                              bottomRight: Radius.circular(14.0),
                            ),
                            child: Image.network(
                              'https://restaurant-api.dicoding.dev/images/large/${restaurant.pictureId}',
                              width: double.infinity,
                              height: 300,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.black54,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.arrow_back_ios_new,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 16.0, 0.0, 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            restaurant.name,
                            style: const TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_sharp,
                                color: Colors.black54,
                                size: 14,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                restaurant.city,
                                style: const TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Icon(
                                Icons.star,
                                color: Colors.black54,
                                size: 14,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                restaurant.rating.toString(),
                                style: const TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(restaurant.description),
                          const SizedBox(height: 10),
                          const Text(
                            'Foods',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 150,
                      child: ListView(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        scrollDirection: Axis.horizontal,
                        children: restaurant.menus.foods.map(
                          (menu) {
                            return Stack(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                          'https://picsum.photos/id/292/200/300'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    child: Center(
                                      child: Text(
                                        menu.name,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ).toList(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 16.0, 0.0, 0.0),
                      child: Column(
                        children: const [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Drinks',
                              style: TextStyle(fontSize: 20.0),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 150,
                      child: ListView(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        scrollDirection: Axis.horizontal,
                        children: restaurant.menus.drinks.map(
                          (menu) {
                            return Stack(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                          'https://picsum.photos/id/30/200/300'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    child: Center(
                                      child: Text(
                                        menu.name,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ).toList(),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            case StatusState.error:
              return Center(
                child: Text('Error : ${state.message}'),
              );
            default:
              return const Center(
                child: Text('Tidak bisa memuat data'),
              );
          }
        },
      ),
    );
  }
}
