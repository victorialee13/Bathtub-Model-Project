import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(const BathtubApp());
}

// 1. The Blueprint & Style
class BathtubApp extends StatelessWidget {
  const BathtubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hides that red 'Debug' banner
      title: 'Bathtub Model',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 33, 81, 120), 
          primary: const Color.fromARGB(255, 0, 10, 18),
        ),
        useMaterial3: true,
      ),
      // 1. ADD THIS: This tells Flutter which screen to open first
      home: const MainDashboard(), 
    );
  }
}

// 2. The Main Page
class MainDashboard extends StatefulWidget{
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboard();
}

class _MainDashboard extends State<MainDashboard> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 242, 247),
      // --- APPBAR ---
      appBar: AppBar(
        title: Text(
          'The Bathtub Model',
          style: GoogleFonts.anta(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 1, 21, 51),
      ),

      // --- BOTTONBAR ---
      bottomNavigationBar: NavigationBar(
        height: 70,
        backgroundColor: const Color.fromARGB(255, 226, 230, 236),
        selectedIndex: currentPageIndex,
        indicatorColor: const Color.fromARGB(255, 176, 185, 200),
        onDestinationSelected: (int index){
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.map),
            icon: Icon(Icons.map_outlined),
            label: 'Map',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.computer),
            icon: Icon(Icons.computer_outlined),
            label: 'Data',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
        ],

      ),

      body: <Widget>[

        // (1) --- MAP PAGE ---
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'The Map',
                textAlign: TextAlign.center,
                style: GoogleFonts.electrolize(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.w600
                ),
              ),

              SizedBox(
                height: 300,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 4,
                  child: FlutterMap(
                    options: const MapOptions(
                      initialCenter: LatLng(33.6405, -117.8443),
                      initialZoom: 13.0,
                    ),
                    children: [
                      // 5. This layer goes out to the internet and downloads the OpenStreetMap images
                      TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.bathtub_model',
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),

        // (2) ---Data Page---
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              // --- Data Page ---
              Text(
                'Data',
                textAlign: TextAlign.center,
                style: GoogleFonts.electrolize(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.w600
                ),
              ),

              const Card(
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                  '''
1.For each individual: Collect their trip emaining time
If the destination is within the bathtub area, remaining time = time needed to end the trip.
If the destination is outside the bathtub area, remaining time = time needed to exit the bathtub area.
                  ''',
                  ),
                ),
              ),

              const Card(
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                  '''
2.For the overall bathtub model:
At time t (i.e. right now):
(1)How many cars have already entered before time t?
(2)How many cars are entering at time t?
(3)How many cars are leaving at time t?
                  ''',
                  ),
                ),
              ),
            ],
          ),
        ),

        // (3) --- Home Page ---
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              // --- Home Page ---
              Text(
                'Home',
                textAlign: TextAlign.center,
                style: GoogleFonts.electrolize(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.w600
                ),
              ),
            ],
          ),
        ),


      ][currentPageIndex],
    );
  }
}