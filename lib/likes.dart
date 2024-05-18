import 'package:flutter/material.dart';

class LikesPage extends StatefulWidget {
  List<String?> likedCats = [];

  LikesPage({Key? key, required this.likedCats}) : super(key: key);

  @override
  _LikesPageState createState() => _LikesPageState();
}

class _LikesPageState extends State<LikesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 255, 220, 239),
                Colors.white,
              ],
            ),
          ),
          height: double.infinity,
          width: double.infinity,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.transparent,
                ),
              ),
              Expanded(
                flex: 8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 70,
                        width: 70,
                        child: Image.asset(
                          'assets/icons/paw.png',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    const Expanded(
                      flex: 1,
                      child: Text(
                        'Liked Cats',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 129, 166),
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Manrope ExtraLight',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: SizedBox(
                          height: MediaQuery.of(context).size.width * 0.82,
                          width: MediaQuery.of(context).size.width,
                          child: ImageList(imageUrls: widget.likedCats)),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ],
          )),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
        child: Container(
          height: 85,
          color: const Color.fromARGB(255, 255, 129, 166),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite, color: Colors.white, size: 45,),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.home, color: Colors.white, size: 45,),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.close, color: Colors.white, size: 45,),
                  ),
                ),
              ],
            ),
          ),
      ),
      );
  }
}

class ImageList extends StatefulWidget {
  final List<String?> imageUrls;

  const ImageList({Key? key, required this.imageUrls}) : super(key: key);

  @override
  _ImageListState createState() => _ImageListState();
}

class _ImageListState extends State<ImageList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.imageUrls.length,
        itemBuilder: (context, index) {
          final imageUrl = widget.imageUrls[index];
          if (imageUrl == null) {
            return const Text('No image');
          } else {
            return Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15), // Adjust the space between images
              child: ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: Image.network(
                  imageUrl,
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover, // Ensure the image fills the container
                  errorBuilder: (context, error, stackTrace) {
                    return const Text('Failed to load image');
                  },
                ),
              ),
            );
          }
        },
      ),
    );
  }


}