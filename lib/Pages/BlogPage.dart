import 'package:NodeWithFlutter/Pages/googleFont.dart';
import 'package:flutter/material.dart';

class BlogPage extends StatefulWidget {
  BlogPage({Key key}) : super(key: key);

  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: home(),
    );
  }

  Widget home() {
    return Scaffold(
       
        
        body: Card(
            color: Color.fromRGBO(20, 12, 122, 0.1),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.purple,
                backgroundImage: AssetImage('assets/profile.jpeg')),
                      
              
              title: Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Text("Trinity",
                        style: googleFont(20, Colors.white, FontWeight.w400)),
                  ),
                  SizedBox(width: 2),
                  Text('',
                      style: googleFont(15, Colors.grey, FontWeight.w300)),
                ],
              ),
              subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Welcome to flutter tutorials',
                          style: googleFont(20, Colors.white, FontWeight.w300)),
                    ),
                    SizedBox(height: 1),
                    
                    Container(
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18.0),
                        child: Image(
                          image: (AssetImage('assets/profile.jpeg')),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              InkWell(onTap: () {}, child: Icon(Icons.comment)),
                              SizedBox(width: 5),
                              Text(
                                '1',
                                style: googleFont(
                                    20, Colors.white, FontWeight.w300),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              InkWell(
                                  onTap: () {},
                                  child: Icon(Icons.favorite_border)),
                              SizedBox(width: 5),
                              Text(
                                '6',
                                style: googleFont(
                                    20, Colors.white, FontWeight.w300),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              InkWell(child: Icon(Icons.share)),
                              SizedBox(width: 5),
                              Text(
                                '10',
                                style: googleFont(
                                    20, Colors.white, FontWeight.w300),
                              ),
                            ],
                          ),
                        ])
                  ]),
            )));
  }
}
