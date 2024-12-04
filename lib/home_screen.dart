import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infoapp/info_screen.dart';
import 'package:infoapp/place_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:infoapp/repository.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PlaceData> allData = Repository().getData(); // Store all data
  List<PlaceData> filteredData = []; // Filtered data to display
  List<String> categoryList = Repository().getCategory();
  TextEditingController controller = TextEditingController();
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Initially show all data
    filteredData = List.from(allData);

    // Listen to changes in the search bar
    controller.addListener(() {
      _applyFilters();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _applyFilters() {
    String searchText = controller.text.toLowerCase();
    String selectedCategory = categoryList[selectedIndex];

    setState(() {
      filteredData = allData.where((place) {
        bool matchesSearch = searchText.isEmpty ||
            place.name.toLowerCase().contains(searchText) ||
            place.tag.toLowerCase().contains(searchText) ||
            place.place.toLowerCase().contains(searchText);

        bool matchesCategory = selectedIndex == 0 || place.tag == selectedCategory;

        return matchesSearch && matchesCategory;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF031F2B),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 32, top: 34),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Sayohat',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 23),
            child: Container(
              height: 55,
              decoration: BoxDecoration(
                color: const Color(0xFF263238),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: controller,
                        style: TextStyle(color: Colors.grey[400]),
                        decoration: const InputDecoration(
                          hintText: 'Buxoro',
                          hintStyle: TextStyle(
                            color: Color(0xFFA5A5A5),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                            fontSize: 16,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Icon(
                      Icons.search,
                      color: Color(0xFFD6D2D2),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 34,
            child: ListView.separated(
              padding: const EdgeInsets.only(left: 32, right: 24),
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                      _applyFilters();
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    decoration: BoxDecoration(
                      color: selectedIndex == index
                          ? const Color(0xFF5EDFFF)
                          : const Color(0xFF263238),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      categoryList[index],
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        color: selectedIndex == index
                            ? const Color(0xFF263238)
                            : const Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(width: 18);
              },
              itemCount: categoryList.length,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 23),
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (context) => InfoScreen(filteredData[index])),
                      );
                    },
                    child: Container(
                      height: 133,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: AssetImage('assets/image/${filteredData[index].image}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.2),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 16,
                            bottom: 36,
                            child: Text(
                              filteredData[index].name,
                              style: const TextStyle(
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 16,
                            bottom: 16,
                            child: Text(
                              filteredData[index].place,
                              style: const TextStyle(
                                fontSize: 10,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w300,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 16);
                },
                itemCount: filteredData.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class HomeScreen extends StatelessWidget {
//   HomeScreen({super.key});
//   var controller = SearchController();
//   List<PlaceData> places = [
//     PlaceData(
//       id: 1,
//       name: "Eiffel Tower",
//       image: "eiffel_tower.jpg",
//       tag: "Landmark",
//       place: "Paris, France",
//       allData: "The Eiffel Tower, built in 1889, stands as an enduring symbol of Paris. Originally constructed as the entrance to the 1889 World's Fair, this iconic iron structure attracts millions of visitors every year. It offers breathtaking panoramic views of the city, making it a must-visit attraction.",
//       rating: "4.8",
//       isPopular: true,
//     ),
//     PlaceData(
//       id: 2,
//       name: "Great Wall of China",
//       image: "great_wall.jpg",
//       tag: "Historical",
//       place: "China",
//       data: "The Great Wall of China is a series of ancient walls and fortifications stretching over 13,000 miles. Built between the 7th and 16th centuries, it was designed to protect China from invasions. Today, it stands as one of the world’s most remarkable architectural achievements.",
//       rating: "4.9",
//       isPopular: true,
//     ),
//     PlaceData(
//       id: 3,
//       name: "Grand Canyon",
//       image: "grand_canyon.jpg",
//       tag: "Nature",
//       place: "Arizona, USA",
//       data: "The Grand Canyon is a massive, steep-sided canyon carved by the Colorado River over millions of years. Known for its stunning layered red rock formations, it provides breathtaking views and a glimpse into Earth’s geological history. It’s a popular destination for hiking, rafting, and photography.",
//       rating: "4.7",
//       isPopular: true,
//     ),
//     PlaceData(
//       id: 4,
//       name: "Mount Fuji",
//       image: "mount_fuji.jpg",
//       tag: "Mountain",
//       place: "Honshu, Japan",
//       data: "Mount Fuji, Japan’s highest peak, is an active stratovolcano revered as a sacred symbol. Rising to 3,776 meters, it attracts climbers and tourists alike. Its symmetrical snow-capped cone is a famous sight, especially during sunrise, and holds cultural significance in Japanese art and folklore.",
//       rating: "4.6",
//       isPopular: true,
//     ),
//     PlaceData(
//       id: 5,
//       name: "Santorini",
//       image: "https://images.unsplash.com/photo-1556740749-887f6717d7e4",
//       tag: "Island",
//       place: "Greece",
//       data: "Santorini is a picturesque Greek island known for its whitewashed buildings, blue-domed churches, and stunning sunsets. Perched on volcanic cliffs, the island offers breathtaking views of the Aegean Sea. Visitors enjoy its beaches, wineries, and unique architecture rooted in ancient history.",
//       rating: "4.9",
//       isPopular: true,
//     ),
//     PlaceData(
//       id: 6,
//       name: "Sydney Opera House",
//       image: "https://images.unsplash.com/photo-1506694641450-6d76b9654855",
//       tag: "Architecture",
//       place: "Sydney, Australia",
//       data: "The Sydney Opera House is an architectural marvel located on Sydney Harbour. Opened in 1973, its unique sail-like design has become an iconic symbol of Australia. It hosts a variety of performances and events, drawing millions of visitors from around the world every year.",
//       rating: "4.8",
//       isPopular: true,
//     ),
//     PlaceData(
//       id: 7,
//       name: "Machu Picchu",
//       image: "https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0",
//       tag: "Historical",
//       place: "Peru",
//       data: "Machu Picchu is an ancient Incan city nestled high in the Andes Mountains of Peru. This UNESCO World Heritage Site is renowned for its stunning terraced fields, temples, and plazas. Its exact purpose remains a mystery, adding to its allure as a cultural and historical gem.",
//       rating: "4.9",
//       isPopular: true,
//     ),
//     PlaceData(
//       id: 8,
//       name: "Banff National Park",
//       image: "https://images.unsplash.com/photo-1542416747-4a4d2e1b165b",
//       tag: "Nature",
//       place: "Alberta, Canada",
//       data: "Banff National Park is Canada’s oldest national park, known for its breathtaking mountain landscapes, turquoise lakes, and diverse wildlife. Located in the Rockies, it offers hiking, skiing, and scenic drives, making it a paradise for nature lovers and outdoor enthusiasts.",
//       rating: "4.7",
//       isPopular: true,
//     ),
//     PlaceData(
//       id: 9,
//       name: "Colosseum",
//       image: "https://images.unsplash.com/photo-1517731983708-3a1073de7b8a",
//       tag: "Historical",
//       place: "Rome, Italy",
//       data: "The Colosseum, an ancient Roman amphitheater, is one of the most iconic structures in the world. Built in AD 80, it hosted gladiator games and public spectacles. Despite its age, it remains a symbol of Rome’s architectural ingenuity and the grandeur of the Roman Empire.",
//       rating: "4.8",
//       isPopular: true,
//     ),
//     PlaceData(
//       id: 10,
//       name: "Bora Bora",
//       image: "https://images.unsplash.com/photo-1552224039-578b8b8ac71c",
//       tag: "Island",
//       place: "French Polynesia",
//       data: "Bora Bora is a tropical paradise famous for its crystal-clear turquoise waters, coral reefs, and luxury overwater bungalows. The island is a popular destination for honeymooners and offers a serene escape with stunning natural beauty and a relaxed island vibe.",
//       rating: "4.9",
//       isPopular: true,
//     ),
//     PlaceData(
//       id: 11,
//       name: "Statue of Liberty",
//       image: "https://images.unsplash.com/photo-1538439855946-49e6392b1e2d",
//       tag: "Landmark",
//       place: "New York, USA",
//       data: "The Statue of Liberty, a gift from France to the United States, stands as a universal symbol of freedom and democracy. Located on Liberty Island in New York Harbor, this iconic statue welcomes millions of visitors each year who come to admire its grandeur and historical significance.",
//       rating: "4.7",
//       isPopular: true,
//     ),
//     PlaceData(
//       id: 12,
//       name: "Pyramids of Giza",
//       image: "https://images.unsplash.com/photo-1548266657-6f81f6b2910f",
//       tag: "Historical",
//       place: "Giza, Egypt",
//       data: "The Pyramids of Giza are among the most famous ancient monuments in the world. Built over 4,500 years ago, they served as tombs for Egyptian pharaohs. Their precise construction remains a marvel of engineering and attracts visitors intrigued by the mysteries of ancient Egypt.",
//       rating: "4.8",
//       isPopular: true,
//     ),
//     PlaceData(
//       id: 13,
//       name: "Niagara Falls",
//       image: "https://images.unsplash.com/photo-1573312115502-e0184d4f57f4",
//       tag: "Nature",
//       place: "Ontario, Canada / New York, USA",
//       data: "Niagara Falls is a breathtaking natural wonder that straddles the border of Canada and the United States. Known for its massive waterfalls and powerful mist, it offers stunning views, boat tours, and nighttime illuminations, making it a popular tourist destination year-round.",
//       rating: "4.6",
//       isPopular: true,
//     ),
//     PlaceData(
//       id: 14,
//       name: "Angkor Wat",
//       image: "https://images.unsplash.com/photo-1559865174-bdd0ed558baf",
//       tag: "Historical",
//       place: "Siem Reap, Cambodia",
//       data: "Angkor Wat, the largest religious monument in the world, was originally constructed as a Hindu temple in the early 12th century. It later became a Buddhist site and is admired for its intricate carvings, massive stone structures, and historical significance as a symbol of Khmer architecture.",
//       rating: "4.9",
//       isPopular: true,
//     ),
//     PlaceData(
//       id: 15,
//       name: "Taj Mahal",
//       image: "https://images.unsplash.com/photo-1549276465-d0cc07bffbd4",
//       tag: "Historical",
//       place: "Agra, India",
//       data: "The Taj Mahal, a magnificent white marble mausoleum, was built by Emperor Shah Jahan in memory of his beloved wife Mumtaz Mahal. Known for its symmetrical beauty, reflective pools, and rich history, it remains one of the most visited and admired monuments in the world.",
//       rating: "4.9",
//       isPopular: true,
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xff031F2B),
//       body: Column(
//         children: [
//           Padding(
//               padding: const EdgeInsets.only(left: 32, right: 32, top: 56),
//               child: Column(
//
//                 children: [
//                   Text(
//                       'Sayohat',
//                       style: GoogleFonts.poppins(
//                           fontSize: 24,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.white
//                       )
//                   ),
//                   SizedBox.square(dimension: 28),
//                   TextField(
//                     maxLines: 1,
//                     maxLength: 25,
//
//                     controller: controller,
//                     style: GoogleFonts.poppins(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w300,
//                       color: Colors.white
//                     ),
//                     decoration: InputDecoration(
//                       hoverColor: Color(0xff263238),
//                       hintText: 'Search',
//                       hintStyle: GoogleFonts.poppins(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w300,
//                         color: Color(0xffA5A5A5)
//                       ),
//                       border: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           width: 0,
//                           color: Color(0xff263238)
//                         ),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                             width: 0,
//                             color: Color(0xff263238)
//                         ),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                             width: 0,
//                             color: Color(0xff263238)
//                         ),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       filled: true,
//                       fillColor: Color(0xff263238),
//                       suffixIcon: Icon(Icons.search,size: 24,color: Color(0xffD6D2D2))
//
//                     ),
//                   ),
//                   ListView.separated(itemBuilder: (){
//                     Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(8)
//                       ),
//                     )
//                   }, separatorBuilder: separatorBuilder, itemCount: itemCount)
//                 ],
//               )
//           ),
//         ],
//       ),
//     );
//   }
// }
