import 'package:bfaf_submission2/data/model/restaurant_list.dart';
import 'package:flutter_test/flutter_test.dart';

import 'list_dummy.dart';

void main () {
  test('Parsing result json', () async {
    var result = RestaurantList.fromJson(dummyListData);

    expect(result.error, dummyListData["error"]);
    expect(result.message, dummyListData["message"]);
    expect(result.count, dummyListData["count"]);
    expect(result.restaurants[0].id, "rqdv5juczeskfw1e867");
    expect(result.restaurants[1].id, "s1knt6za9kkfw1e867");
    expect(result.restaurants.length, 2);
  });
}