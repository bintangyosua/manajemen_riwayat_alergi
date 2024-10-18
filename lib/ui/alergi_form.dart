import 'package:flutter/material.dart';
import 'package:manajemen_riwayat_alergi/bloc/alergi_bloc.dart';
import 'package:manajemen_riwayat_alergi/model/alergi.dart';
import 'package:manajemen_riwayat_alergi/ui/alergi_page.dart';
import 'package:manajemen_riwayat_alergi/widget/warning_dialog.dart';

// ignore: must_be_immutable
class AlergiForm extends StatefulWidget {
  Alergi? alergi;
  AlergiForm({Key? key, this.alergi}) : super(key: key);
  @override
  _AlergiFormState createState() => _AlergiFormState();
}

class _AlergiFormState extends State<AlergiForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "Tambah Riwayat Alergi";
  String tombolSubmit = "Simpan";
  final _kodeAlergiTextboxController = TextEditingController();
  final _namaAlergiTextboxController = TextEditingController();
  final _hargaAlergiTextboxController = TextEditingController();
  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.alergi != null) {
      setState(() {
        judul = "Ubah Riwayat Alergi";
        tombolSubmit = "Ubah";
        _kodeAlergiTextboxController.text = widget.alergi!.allergen!;
        _namaAlergiTextboxController.text = widget.alergi!.reaction!;
        _hargaAlergiTextboxController.text =
            widget.alergi!.severity_scale.toString();
      });
    } else {
      judul = "Tambah Riwayat Alergi";
      tombolSubmit = "Simpan";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _kodeAlergiTextField(),
                _namaAlergiTextField(),
                _hargaAlergiTextField(),
                const SizedBox(height: 10),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

//Membuat Textbox Kode Alergi
  Widget _kodeAlergiTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Kode Alergi"),
      keyboardType: TextInputType.text,
      controller: _kodeAlergiTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Kode Alergi harus diisi";
        }
        return null;
      },
    );
  }

//Membuat Textbox Nama Alergi
  Widget _namaAlergiTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama Alergi"),
      keyboardType: TextInputType.text,
      controller: _namaAlergiTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama Alergi harus diisi";
        }
        return null;
      },
    );
  }

//Membuat Textbox Harga Alergi
  Widget _hargaAlergiTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Harga"),
      keyboardType: TextInputType.number,
      controller: _hargaAlergiTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Harga harus diisi";
        }
        return null;
      },
    );
  }

//Membuat Tombol Simpan/Ubah
  Widget _buttonSubmit() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE1AFD1),
        ),
        child: Text(
          tombolSubmit,
          style: const TextStyle(color: Colors.white),
        ),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) {
              if (widget.alergi != null) {
//kondisi update alergi
                ubah();
              } else {
//kondisi tambah alergi
                simpan();
              }
            }
          }
        });
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    Alergi createAlergi = Alergi(id: null);
    createAlergi.allergen = _kodeAlergiTextboxController.text;
    createAlergi.reaction = _namaAlergiTextboxController.text;
    createAlergi.severity_scale = int.parse(_hargaAlergiTextboxController.text);
    AlergiBloc.addAlergi(alergi: createAlergi).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const AlergiPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Simpan gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    Alergi updateAlergi = Alergi(id: widget.alergi!.id!);
    updateAlergi.allergen = _kodeAlergiTextboxController.text;
    updateAlergi.reaction = _namaAlergiTextboxController.text;
    updateAlergi.severity_scale = int.parse(_hargaAlergiTextboxController.text);
    AlergiBloc.updateAlergi(alergi: updateAlergi).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const AlergiPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Permintaan ubah data gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}
