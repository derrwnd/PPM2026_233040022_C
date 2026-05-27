import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: const Center(
          child: Text(
            'Latihan Icon & Bottom Bar',
            style: TextStyle(fontSize: 24),
          ),
        ),

        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,

          items: const [

            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                color: Colors.red,
                size: 32,
              ),
              label: 'Favorit',
            ),

            BottomNavigationBarItem(
              icon: Icon(
                Icons.star,
                color: Colors.green,
                size: 32,
              ),
              label: 'Bintang',
            ),

            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.purple,
                size: 32,
              ),
              label: 'Home',
            ),

            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Colors.blue,
                size: 32,
              ),
              label: 'Profil',
            ),

          ],
        ),
      ),
    ),
  );
}