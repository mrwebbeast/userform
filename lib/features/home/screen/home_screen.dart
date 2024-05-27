import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:mrwebbeast/utils/theme/shadows.dart";

import "package:mrwebbeast/core/routes/route_configs.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //todo:- Required if Location based Application
      // context.read<LocationController>().determinePosition(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Home Screen"),
        actions: [
          IconButton(
            onPressed: () {
              context.push(Routes.manageUsers);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(left: 16, right: 16, top: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: primaryBoxShadow(context),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text("${index + 1}) Sahil Ranout"),
              subtitle: const Text("mrwebbeast@gmail.com"),
              trailing: const Text("Male"),
            ),
          );
        },
      ),
    );
  }
}
