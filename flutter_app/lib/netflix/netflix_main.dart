import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/netflix/model/movie.dart';
import 'package:flutter_app/netflix/movie_page.dart';

class NetflixMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NetflixHome(),
    );
  }
}

class NetflixHome extends StatefulWidget {
  @override
  _NetflixHomeState createState() => _NetflixHomeState();
}

class _NetflixHomeState extends State<NetflixHome> {
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  _buildBody() => ListView(children: [
        Container(
          height: 280.0,
          width: double.infinity,
          child: PageView.builder(
            controller: _pageController,
            itemCount: movies.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildSelectorMovie(index);
            },
          ),
        ),
        const SizedBox(height: 20),
        _buildListLabels(),
        const SizedBox(
          height: 20,
        ),
        _buildTitleMyList("My List"),
        const SizedBox(
          height: 20,
        ),
        _buildMyList(myList),
        const SizedBox(
          height: 30,
        ),
        _buildTitleMyList("My List"),
        const SizedBox(
          height: 30,
        ),
        _buildMyList(popular),
      ]);

  _buildAppbar() => AppBar(
        backgroundColor: Colors.white,
        leading: Icon(Icons.menu, color: Colors.black),
        title: Center(
            child: Image.asset(
          'assets/images/netflix_logo.png',
          width: 100,
          height: 100,
        )),
        actions: <Widget>[Icon(Icons.search, color: Colors.black)],
      );

  _buildSelectorMovie(int index) => AnimatedBuilder(
    animation: _pageController,
    builder: (BuildContext context, widget) {
      double value = 1;
      if (_pageController.position.haveDimensions) {
        value = _pageController.page - index;
        value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        print(value);
      }
      return Center(
        child: SizedBox(
          height: Curves.easeInOut.transform(value) * 270.0,
          width: Curves.easeInOut.transform(value) * 400.0,
          child: widget,
        ),
      );
    },
    child: GestureDetector(
      onTap: (){
        Navigator.push(context,  MaterialPageRoute(builder: (_) => MovieDetail(movie: movies[index],))
       );

      },
      child: Hero(
        tag: movies[index].imageUrl,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black54,
                        blurRadius: 10,
                        offset: Offset(0.0, 4.0))
                  ]),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    movies[index].imageUrl,
                    height: 280,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 40,
              bottom: 30,
              child: Container(
                width: 250.0,
                child: Text(
                  movies[index].title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );

  _buildListLabels() => Container(
        height: 90,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: labels.length,
            itemBuilder: (BuildContext context, index) {
              return _buildItemLabel(label: labels[index]);
            }),
      );

  _buildItemLabel({String label}) => Container(
        width: 160,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFD45253),
                  Color(0xFF9E1F28),
                ]),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color(0xFF9E1F28),
                offset: Offset(0.0, 2.0),
                blurRadius: 6.0,
              )
            ]),
        child: Center(
          child: Text(
            label.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.8,
            ),
          ),
        ),
      );

  _buildTitleMyList(String title) => Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Icon(Icons.arrow_forward),
          ],
        ),
      );

  _buildMyList(List<String> listImage) => Container(
        height: 260,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listImage.length,
            itemBuilder: (BuildContext context, index) {
              return _buildItemMyList(listImage[index]);
            }),
      );

  _buildItemMyList(String imageUrl) => Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0.0, 10.0))
            ]),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover,
            )),
      );
}
