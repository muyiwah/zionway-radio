import 'package:flutter/material.dart';

class RadioUi extends StatelessWidget {
  const RadioUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[800],
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70),
          child: Container(
            child: Text('Faith Radio'),
          ),
        ),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Faith Radio"),
              accountEmail: Text("Connect with us"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  "FR",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              // leading: FaIcon(FontAwesomeIcons.facebook,
              //     color: Colors.blue, size: 30),
              title: const Text(
                'Facebook',
              ),

              onTap: () async {
                final Uri url =
                    Uri.parse('https://web.facebook.com/waterradiong');

                // if (await canLaunchUrl(url)) {
                //   await launchUrl(url);
                // } else {
                //   throw 'Could not launch $url';
                // }
                Navigator.pop(context);
              },
            ),
            ListTile(
              // leading:
              //     FaIcon(FontAwesomeIcons.youtube, color: Colors.red, size: 30),
              title: const Text(
                'Youtube',
              ),
              onTap: () async {
                final Uri url = Uri.parse(
                    'https://www.youtube.com/channel/UCimib4j_ayASl-1jPbFsNyg');

                // if (await canLaunchUrl(url)) {
                //   await launchUrl(url);
                // } else {
                //   throw 'Could not launch $url';
                // }
                Navigator.pop(context);
              },
            ),
            ListTile(
              // leading: FaIcon(FontAwesomeIcons.instagram,
              //     color: Colors.red, size: 30),
              title: const Text(
                'Instagram',
              ),
              onTap: () async {
                final Uri url =
                    Uri.parse('https://www.instagram.com/official_waterradio/');

                // if (await canLaunchUrl(url)) {
                //   await launchUrl(url);
                // } else {
                //   throw 'Could not launch $url';
                // }
                Navigator.pop(context);
              },
            ),
            ListTile(
              // leading: const FaIcon(FontAwesomeIcons.twitter,
              //     color: Colors.blue, size: 30),
              title: const Text(
                'Twitter',
              ),
              // image: Image.asset('lib/icons/facebook.png'),
              onTap: () async {
                final Uri url = Uri.parse('https://twitter.com/waterradio3');

                // if (await canLaunchUrl(url)) {
                //   await launchUrl(url);
                // } else {
                //   throw 'Could not launch $url';
                // }
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: Color.fromARGB(255, 189, 61, 189)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset('lib/images/faithradio.jpg'),
            ),
          ),
          Container(
            child: Expanded(
                child: SizedBox(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.1, 0.4, 0.7, 0.9],
                    colors: [
                      Color(0xFF3594DD),
                      Color(0xFF4563DB),
                      Color(0xFF5036D5),
                      Color(0xFF5816DB),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Faith',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'the substance of things hoped for',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'off air',
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(
                          Icons.shuffle,
                          color: Colors.white,
                        ),
                        Icon(
                          Icons.repeat,
                          color: Colors.white,
                        ),
                        // LottieScreen(),
                        Text(
                          '0:00',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    Container(child: Text('now playing')),
                  ],
                ),
                // color: Colors.deepPurple,
              ),
              width: double.infinity,
            )),
          )
        ],
      ),
    );
  }
}
