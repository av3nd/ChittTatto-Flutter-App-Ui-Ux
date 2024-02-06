import "package:flutter/material.dart";

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundColor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unselectedNavBarColor = Colors.black87;

  // STATIC IMAGES
  static const List<String> carouselImages = [
    'https://cdn.pixabay.com/photo/2021/07/19/16/04/pizza-6478478_640.jpg',
    'https://media.istockphoto.com/id/467416670/photo/huge-grass-fed-bison-hamburger-with-chips-beer.jpg?s=612x612&w=0&k=20&c=NA5S3gfJYRydMViaUMHz2d7wHuexygVM02xkiaE2p3c=',
    'https://media.istockphoto.com/id/483137365/photo/asian-chow-mein-noodles.jpg?s=612x612&w=0&k=20&c=aVkPKpDkiAM7CxTFinQBax0i-nm-ybzWimrJRyPePcg=',
    'https://media.istockphoto.com/id/1133151212/photo/japanese-dumplings-gyoza-with-pork-meat-and-vegetables.jpg?s=612x612&w=0&k=20&c=vC6GTUDGK6dD5_QHvY1V7fVUdPx-z4TG73DUACR_L5s=',
    'https://media.istockphoto.com/id/958479202/photo/traditional-nepalese-food-thali.jpg?s=612x612&w=0&k=20&c=67AbwSD7Lwo1xImPMX1cGut5Cc9MWqKkiu3pY6dTIkg=',
    'https://media.istockphoto.com/id/501150349/photo/chicken-biryani-11.jpg?s=612x612&w=0&k=20&c=w6mDnUx8MnH3rnP9bR0VfWRwrODcbTz-6U07o3Zrs4o=',
    'https://media.istockphoto.com/id/589127624/photo/meat-kebabs-with-vegetables-on-flaming-grill.jpg?s=612x612&w=0&k=20&c=IyJ9EWA1fWa7xNTePVjKx6VtU11H9RrDBlT5ZzDce6g=',
    'https://media.istockphoto.com/id/1205762531/photo/stuffed-paratha.jpg?s=612x612&w=0&k=20&c=vztUKV1MhN3kRvaBigoUeDifuy0PG85eB0gTKsfn0Bo=',
    'https://media.istockphoto.com/id/995903748/photo/smoked-and-spicy-tandoori-chicken-grilling-with-smoke.jpg?s=612x612&w=0&k=20&c=xq_apF2Osk5HYFOgBS9crRi1puLozxyGWFuCUV0mhYg=',
    'https://media.istockphoto.com/id/1365977387/photo/ramen-with-steaming-sizzle.jpg?s=612x612&w=0&k=20&c=8-Dij3YocgfVa2kj37msXT_iqzIgbqq0Ta3c1G4_-A0=',
    'https://media.istockphoto.com/id/1150376593/photo/bread-tandoori-indian-cuisine.jpg?s=612x612&w=0&k=20&c=GGT5LN7G4zLhJTEnP_KcyvYuayi8f1nJcvQwvmj0rCM=',
    'https://media.istockphoto.com/id/1325172440/photo/spaghetti-alla-puttanesca-italian-pasta-dish-with-tomatoes-black-olives-capers-anchovies-and.jpg?s=612x612&w=0&k=20&c=ieMxGg7flhSltOMDpuLZINAWYT2W2WDjJTlwoUWuwH4='
  ];
}
