import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'restaurant.dart';

// Provided JSON data given for the test
const String jsonData = '''
[
    {
        "id": 1,
        "name": "The Smokehouse",
        "cuisine": "Barbecue"
    },
    {
        "id": 2,
        "name": "Pinocchio's Pizza",
        "cuisine": "Italian"
    },
    {
        "id": 3,
        "name": "Felipe's Taqueria",
        "cuisine": "Mexican"
    },
    {
        "id": 4,
        "name": "Tasty Burger",
        "cuisine": "American"
    }
]
''';

// Parsing JSON data
final List<Restaurant> restaurants = (jsonDecode(jsonData) as List)
    .map((data) => Restaurant.fromJson(data))
    .toList();

// Providers
final restaurantListProvider =
    StateProvider<List<Restaurant>>((ref) => restaurants);

final searchProvider = StateProvider<String>((ref) => '');

// Filtered restaurants provider
final filteredRestaurantsProvider = Provider<List<Restaurant>>((ref) {
  final search = ref.watch(searchProvider).toLowerCase();
  final restaurantList = ref.watch(restaurantListProvider);

  if (search.isEmpty) {
    return restaurantList;
  } else {
    return restaurantList
        .where((restaurant) => restaurant.name.toLowerCase().contains(search))
        .toList();
  }
});
