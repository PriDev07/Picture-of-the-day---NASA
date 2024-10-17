import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasa_api/components/potd-card.dart';
import 'package:nasa_api/models/potd.dart';
import 'package:nasa_api/services/remote_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Potd>? potd;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    potd = await RemoteService().getPotd();
    if (potd != null) {
      potd!.sort((a, b) => b.date.compareTo(a.date));
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SvgPicture.asset("assets/nasa-logo.svg"),
        title: Text(
          "NASA",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 74, 96, 132),
      ),
      body: Visibility(
        visible: isLoaded,
        replacement: Center(child: CircularProgressIndicator()),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: PotdCard(potd: potd),
        ),
      ),
    );
  }
}
