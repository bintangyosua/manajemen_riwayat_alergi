import 'package:flutter/material.dart';
import 'package:manajemen_riwayat_alergi/bloc/produk_bloc.dart';
import 'package:manajemen_riwayat_alergi/model/produk.dart';
import 'package:manajemen_riwayat_alergi/ui/produk_form.dart';
import 'package:manajemen_riwayat_alergi/ui/produk_page.dart';
import 'package:manajemen_riwayat_alergi/widget/warning_dialog.dart';

// ignore: must_be_immutable
class ProdukDetail extends StatefulWidget {
  Produk produk;
  ProdukDetail({Key? key, required this.produk}) : super(key: key);
  @override
  _ProdukDetailState createState() => _ProdukDetailState();
}

class _ProdukDetailState extends State<ProdukDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Riwayat Penyakit'),
      ),
      body: Center(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.local_hospital),
              title:
                  Text('Allergen: ${widget.produk.allergen}' ?? 'Tanpa nama'),
              subtitle: const Text('Nama alergen yang menyebabkan reaksi'),
            ),
            ListTile(
              leading: const Icon(Icons.sick),
              title:
                  Text('Reaction: ${widget.produk.reaction}' ?? 'Tanpa nama'),
              subtitle: const Text(
                  'Jenis reaksi yang terjadi akibat kontak dengan alergen.'),
            ),
            ListTile(
              leading: const Icon(Icons.numbers),
              title: Text(
                  'Severity Scale: ${widget.produk.severity_scale.toString()}'),
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
                builder: (context) => ProdukForm(
                  produk: widget.produk,
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
            ProdukBloc.deleteProduk(id: widget.produk.id!).then(
                (value) => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ProdukPage()))
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
