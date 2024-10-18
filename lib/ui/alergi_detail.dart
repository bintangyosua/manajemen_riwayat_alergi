import 'package:flutter/material.dart';
import 'package:manajemen_riwayat_alergi/bloc/alergi_bloc.dart';
import 'package:manajemen_riwayat_alergi/model/alergi.dart';
import 'package:manajemen_riwayat_alergi/ui/alergi_form.dart';
import 'package:manajemen_riwayat_alergi/ui/alergi_page.dart';
import 'package:manajemen_riwayat_alergi/widget/warning_dialog.dart';

// ignore: must_be_immutable
class AlergiDetail extends StatefulWidget {
  Alergi alergi;
  AlergiDetail({Key? key, required this.alergi}) : super(key: key);
  @override
  _AlergiDetailState createState() => _AlergiDetailState();
}

class _AlergiDetailState extends State<AlergiDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Riwayat Alergi'),
      ),
      body: Center(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.local_hospital),
              title:
                  Text('Allergen: ${widget.alergi.allergen}' ?? 'Tanpa nama'),
              subtitle: const Text('Nama alergen yang menyebabkan reaksi'),
            ),
            ListTile(
              leading: const Icon(Icons.sick),
              title:
                  Text('Reaction: ${widget.alergi.reaction}' ?? 'Tanpa nama'),
              subtitle: const Text(
                  'Jenis reaksi yang terjadi akibat kontak dengan alergen.'),
            ),
            ListTile(
              leading: const Icon(Icons.numbers),
              title: Text(
                  'Severity Scale: ${widget.alergi.severity_scale.toString()}'),
              subtitle: const Text(
                  'Tingkat keparahan reaksi, biasanya dalam skala 1 hingga 5, di mana 1 adalah ringan dan 5 adalah sangat serius.'),
            ),
            const SizedBox(
              height: 10,
            ),
            _tombolHapusEdit()
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
// Tombol Edit
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(const Color(0xFFAD88C6)),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AlergiForm(
                  alergi: widget.alergi,
                ),
              ),
            );
          },
          child: const Text(
            "Edit",
            style: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(width: 10),
// Tombol Hapus
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  WidgetStateProperty.all(const Color(0xFFE1AFD1))),
          onPressed: () => confirmHapus(),
          child: const Text(
            "Delete",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
//tombol hapus
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  WidgetStateProperty.all(const Color(0xFFF05A7E))),
          child: const Text(
            "Ya",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            AlergiBloc.deleteAlergi(id: widget.alergi.id!).then(
                (value) => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const AlergiPage()))
                    }, onError: (error) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                        description: "Hapus gagal, silahkan coba lagi",
                      ));
            });
          },
        ),
//tombol batal
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
    showDialog(builder: (context) => alertDialog, context: context);
  }
}
