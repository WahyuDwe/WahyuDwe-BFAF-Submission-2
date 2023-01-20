import 'package:bfaf_submission2/provider/restaurant_db_provider.dart';
import 'package:bfaf_submission2/ui/restaurant_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/model/restaurant_list.dart';
import '../utils/result_state.dart';

class RestaurantFavoritePage extends StatelessWidget {
  static const routeName = '/favorite_page';

  const RestaurantFavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite'),
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return Consumer<RestaurantDatabaseProvider>(
      builder: (context, state, _) {
        switch (state.state) {
          case StatusState.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case StatusState.noData:
            return Center(
              child: Text(state.message),
            );
          case StatusState.hasData:
            return ListView.builder(
              itemCount: state.favorite.length,
              itemBuilder: (context, index) =>
                  _buildRestoItem(context, state.favorite[index]),
            );
          case StatusState.error:
            return Center(
              child: Text(state.message),
            );
          default:
            return const Center(
              child: Text('Error'),
            );
        }
      },
    );
  }

  Widget _buildRestoItem(BuildContext context, RestaurantListElement resto) {
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
            resto.pictureId != ''
                ? Flexible(
                  child: Hero(
                      tag: resto.pictureId!,
                      child: Image.network(
                        'https://restaurant-api.dicoding.dev/images/small/${resto.pictureId}',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                )
                : const SizedBox(
                    width: 100,
                    height: 100,
                    child: Center(
                      child: Text('No Image'),
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
