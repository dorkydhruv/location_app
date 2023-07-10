import 'package:flutter/material.dart';
import 'package:location_app/providers/great_places.dart';
import 'package:location_app/screen/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Places you visited!'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: const Icon(Icons.add_a_photo_rounded),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(child: CircularProgressIndicator())
                : Consumer<GreatPlaces>(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Center(
                            child: Text(
                              'Got NO Places yet Start adding..|',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          FloatingActionButton(
                            onPressed: () => Navigator.of(context)
                                .pushNamed(AddPlaceScreen.routeName),
                            child: const Icon(Icons.add_a_photo),
                          ),
                        ],
                      ),
                    ),
                    builder: (context, greatPlaces, child) =>
                        greatPlaces.items.isEmpty
                            ? child!
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: ListView.builder(
                                    itemBuilder: (context, index) => ListTile(
                                      leading: CircleAvatar(
                                        // minRadius:,
                                        backgroundImage: FileImage(
                                            greatPlaces.items[index].image),
                                      ),
                                      title: Text(
                                        greatPlaces.items[index].title,
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      onTap: () {},
                                    ),
                                    itemCount: greatPlaces.items.length,
                                  ),
                                ),
                              ),
                  ),
      ),
    );
  }
}
