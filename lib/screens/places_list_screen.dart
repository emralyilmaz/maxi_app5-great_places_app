import 'dart:io';

import 'package:flutter/material.dart';
import 'package:maxi_app5_great_places_app/models/place.dart';
import 'package:maxi_app5_great_places_app/providers/great_places.dart';
import 'package:maxi_app5_great_places_app/screens/add_place_screen.dart';
import 'package:provider/provider.dart';
import 'dart:io' as io;

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Places"),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              })
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                child: Center(
                  child: const Text('Got no places yet, start adding some!'),
                ),
                builder: (ctx, greatPlaces, ch) => greatPlaces.items.length <= 0
                    ? ch
                    : ListView.builder(
                        itemCount: greatPlaces.items.length,
                        itemBuilder: (ctx, i) =>
                            buildItem(greatPlaces.items[i]),
                      ),
              ),
      ),
    );
  }

  buildItem(Place place) {
    // bool exist = await io.File(place.image.path).exists();
    // bool exist = File(place.image.path).existsSync();
    // if (exist) {
    try {
      return ListTile(
        leading: CircleAvatar(
          backgroundImage: FileImage(
            place.image,
          ),
        ),
        title: Text(place.title),
        onTap: () {
          // Go to detail page ...
        },
      );
    } catch (ex) {
      print(ex.toString());
    }
    // } else {
    //   SizedBox();
    // }
  }
}
