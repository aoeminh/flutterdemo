import 'package:flutter/material.dart';
import 'package:flutter_app/netflix/model/movie.dart';

import 'custom_cliper.dart';

class MovieDetail extends StatefulWidget {
  final Movie movie;

  const MovieDetail({Key key, this.movie}) : super(key: key);

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  _buildBody() => SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                    child: Hero(
                      tag: widget.movie.title,
                      child: ClipShadowPath(
                        cliper: CustomImageCliper(),
                        shadow: Shadow(blurRadius: 20),
                        widget: Image(
                          image: AssetImage(widget.movie.imageUrl),
                          width: double.infinity,
                          height: 400,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  _buildPlayButton(),
                  _buildToolbar(),
                  Positioned(
                      bottom: 0,
                      left: 20,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.add),
                      )),
                  Positioned(
                      bottom: 0,
                      right: 20,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.share),
                      )),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                width: 200,
                child: Center(
                  child: Text(
                    widget.movie.title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Text(widget.movie.categories),
              const SizedBox(height: 10.0),
              Container(
                child: Center(
                  child: Text(
                    '⭐ ⭐ ⭐ ⭐',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              _buildMovieInfo(),
              const SizedBox(height: 10.0),
              _buildDescription(),
              const SizedBox(height: 10.0),
              _buildTitleMyList('Screenshots'),
              const SizedBox(height: 10.0),
              _buildMyList(widget.movie.screenshots)
            ],
          ),
        ),
      );

  _buildToolbar() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            padding: EdgeInsets.only(left: 20, top: 20),
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          Container(
            padding: EdgeInsets.only(top: 20),
            child: Image(
              image: AssetImage('assets/images/netflix_logo.png'),
              width: 150,
              height: 60,
            ),
          ),
          IconButton(
            padding: EdgeInsets.only(right: 20, top: 20),
            icon: Icon(Icons.favorite_border),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      );

  _buildPlayButton() => Positioned.fill(
        bottom: 10,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: RawMaterialButton(
            fillColor: Colors.white,
            padding: EdgeInsets.all(10),
            elevation: 12,
            shape: CircleBorder(),
            onPressed: () => print('play'),
            child: Icon(
              Icons.play_arrow,
              size: 60,
              color: Colors.red,
            ),
          ),
        ),
      );

  _buildMovieInfo() => Container(
        width: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildInfo('Year', widget.movie.year.toString()),
            _buildInfo('Country', widget.movie.country),
            _buildInfo('Length', widget.movie.length.toString())
          ],
        ),
      );

  _buildInfo(String title, String info) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 12, color: Colors.black38),
          ),
          Text(info,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ],
      );

  _buildDescription() => Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          widget.movie.description,
          style: TextStyle(fontSize: 12, color: Colors.black38),
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
        height: 100,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listImage.length,
            itemBuilder: (BuildContext context, index) {
              return _buildItemMyList(listImage[index]);
            }),
      );

  _buildItemMyList(String imageUrl) => Container(
        width: 150,
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
