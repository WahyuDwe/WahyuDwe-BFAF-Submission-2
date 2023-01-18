import 'package:bfaf_submission2/data/model/restaurant_list.dart';
import 'package:bfaf_submission2/data/model/restaurant_search_list.dart';
import 'package:bfaf_submission2/provider/restaurant_search_provider.dart';
import 'package:bfaf_submission2/ui/restaurant_detail_page.dart';
import 'package:bfaf_submission2/utils/result_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantSearchPage extends StatefulWidget {
  const RestaurantSearchPage({Key? key}) : super(key: key);

  static const routeName = '/restaurant_search_page';

  @override
  State<RestaurantSearchPage> createState() => _RestaurantSearchPageState();
}

class _RestaurantSearchPageState extends State<RestaurantSearchPage> {
  String _query = '';
  TextEditingController _controller = TextEditingController();


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Consumer<RestaurantSearchProvider>(
        builder: (context, state, _) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'Search Restaurant',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  onChanged: (String text) {
                    setState(() {
                      _query = text;
                      state.fetchRestaurantSearch(text);
                    });
                  },
                ),
              ),
              Expanded(
                child: _buildList(context),
              ),
            ],
          );
        },
      ),
    );
  }

  _buildList(BuildContext context) {
    return Consumer<RestaurantSearchProvider>(
      builder: (context, state, _) {
        ResultState<RestaurantSearchList> result = state.state;
        switch (result.status) {
          case StatusState.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case StatusState.hasData:
            return ListView.builder(
              itemCount: result.data!.restaurants.length,
              itemBuilder: (context, index) {
                var restaurant = result.data!.restaurants[index];
                return _buildRestoItem(context, restaurant);
              },
            );
          case StatusState.noData:
            return const Center(
              child: Text('Restaurant tidak di temukan'),
            );
          case StatusState.textFieldEmpty:
            return const Center(
              child: Text('Masukan nama restaurant'),
            );
          case StatusState.error:
            return Center(
              child: Text('Error : ${result.message}'),
            );
          default:
            return const Center(
              child: Text(''),
            );
        }
      },
    );
  }

  _buildRestoItem(BuildContext context, RestaurantListElement resto) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
      ),
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, RestaurantDetailPage.routeName,
              arguments: resto.id);
        },
        child: Row(
          children: [
            Hero(
              tag: resto.pictureId,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(14.0),
                  bottomLeft: Radius.circular(14.0),
                ),
                child: Image.network(
                  "https://restaurant-api.dicoding.dev/images/small/${resto.pictureId}",
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      resto.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 14,
                        ),
                        Text(
                          resto.city,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 14,
                        ),
                        Text(
                          resto.rating.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
