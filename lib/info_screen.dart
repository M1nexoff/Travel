import 'package:flutter/material.dart';
import 'package:infoapp/place_data.dart';

/*

Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(placeData.imgAsset),
                      fit: BoxFit.cover,
                      alignment: AlignmentDirectional.bottomCenter
                  ),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50)
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(1),
                    ],
                  ),
                ),
                child: Stack(
                  children: [

                  ],
                ),
              )

* */

class InfoScreen extends StatelessWidget {
  PlaceData placeData;

  InfoScreen(this.placeData);

  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _isExpandedNotifier = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      _isExpandedNotifier.value = _scrollController.offset == 0;
    });
    return Scaffold(
        backgroundColor: const Color(0xFF031F2B),
        body: Column(
          children: [
            Expanded(
              child: Container(
                child: ValueListenableBuilder<bool>(
                    valueListenable: _isExpandedNotifier,
                    builder: (context, isExpanded, child) {
                      return CustomScrollView(
                        controller: _scrollController,
                        slivers: [
                          SliverAppBar(
                            pinned: true,
                            stretch: true,
                            automaticallyImplyLeading: false,
                            backgroundColor: const Color(0xFF031F2B),
                            expandedHeight: 361.0,
                            primary: true,
                            flexibleSpace: FlexibleSpaceBar(
                              expandedTitleScale: 1,
                              centerTitle: false,
                              title: Stack(
                                children: [
                                  Positioned(
                                    left: 32,
                                    bottom: isExpanded ? 40 : 0,
                                    child: Text(
                                      placeData.name,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFFFFFFFF)),
                                    ),
                                  )
                                ],
                              ),
                              background: Stack(
                                children: [
                                  Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage('assets/image/${placeData.image}'),
                                            fit: BoxFit.cover,
                                            alignment:
                                                AlignmentDirectional.bottomCenter),
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(50),
                                            bottomRight: Radius.circular(50)),
                                      )),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(50),
                                            bottomRight: Radius.circular(50)),
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.transparent,
                                            Colors.black.withOpacity(0.3),
                                          ],
                                        )),
                                  ),
                                  Positioned(
                                    top: 48,
                                    left: 32,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        width: 34,
                                        height: 34,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: Colors.white.withOpacity(.30)),
                                        child: const Icon(
                                          Icons.arrow_back_ios_new,
                                          color: Colors.white,
                                          size: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    bottom: 0,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 32, bottom: 12),
                                      child: Text(
                                        placeData.place,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w300,
                                            color: Color(0xFFFFFFFF)),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 32,
                                    bottom: 18,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          placeData.rating.toString(),
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFFFFFFFF)),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 4),
                                          child: Icon(Icons.star,
                                              color: Color(0xFFE58F3F)),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              stretchModes: const <StretchMode>[
                                StretchMode.zoomBackground,
                                StretchMode.blurBackground
                              ],
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.only(left: 32, top: 24, bottom: 8),
                              child: Text(
                                'Batafsil',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFFFFFFFF)),
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 32),
                                  child: Text(
                                    placeData.data,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFFFFFFFF)),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(0xFF5EDFFF),
                            width: 1,
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.map_outlined,
                              color: Color(0xFF5EDFFF),
                              size: 24,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Joylashuv',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF5EDFFF)),
                            ),
                          ],
                        ),
                      )),
                  SizedBox(width: 18),
                  Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(0xFF5EDFFF),
                            width: 1,
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.language_outlined,
                              color: Color(0xFF5EDFFF),
                              size: 24,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Manba',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF5EDFFF)),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
            SizedBox.square(dimension: 24,)
          ],
        ));
  }
}
