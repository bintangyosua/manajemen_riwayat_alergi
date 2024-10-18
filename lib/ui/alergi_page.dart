import 'package:flutter/material.dart';
import 'package:manajemen_riwayat_alergi/bloc/logout_bloc.dart';
import 'package:manajemen_riwayat_alergi/bloc/alergi_bloc.dart';
import 'package:manajemen_riwayat_alergi/model/alergi.dart';
import 'package:manajemen_riwayat_alergi/ui/login_page.dart';
import 'package:manajemen_riwayat_alergi/ui/alergi_detail.dart';
import 'package:manajemen_riwayat_alergi/ui/alergi_form.dart';

class AlergiPage extends StatefulWidget {
  const AlergiPage({Key? key}) : super(key: key);
  @override
  _AlergiPageState createState() => _AlergiPageState();
}

class _AlergiPageState extends State<AlergiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Riwayat Alergi'),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                child: const Icon(Icons.add, size: 26.0),
                onTap: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AlergiForm()));
                },
              ))
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromRGBO(165, 182, 141, 1),
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                await LogoutBloc.logout().then((value) => {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false)
                    });
              },
            )
          ],
        ),
      ),
      body: FutureBuilder<List>(
        future: AlergiBloc.getAlergis(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListAlergi(
                  list: snapshot.data,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ListAlergi extends StatelessWidget {
  final List? list;
  const ListAlergi({Key? key, this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list!.length,
        itemBuilder: (context, i) {
          return ItemAlergi(
            alergi: list![i],
          );
        });
  }
}

class ItemAlergi extends StatelessWidget {
  final Alergi alergi;
  const ItemAlergi({Key? key, required this.alergi}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AlergiDetail(
                      alergi: alergi,
                    )));
      },
      child: Card(
        color: Colors.white,
        child: ListTile(
          title: Text(alergi.allergen!),
          subtitle: Text(alergi.reaction.toString()),
        ),
      ),
    );
  }
}
