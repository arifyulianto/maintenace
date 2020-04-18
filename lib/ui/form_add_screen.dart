import 'package:maintenace/model/site.dart';
import 'package:maintenace/api/apiservice.dart';
import 'package:flutter/material.dart';
import 'package:maintenace/ui/home_screen.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class FormAddScreen extends StatefulWidget {
  Site site;
  FormAddScreen({this.site});
  @override
  _FormAddScreenState createState() => _FormAddScreenState();
}

class _FormAddScreenState extends State<FormAddScreen> {
  bool _isLoading = false;
  ApiService _apiService = ApiService();
  bool _isFieldNamaValid;
  bool _isFieldKeteranganValid;
  TextEditingController _controllerNama = TextEditingController();
  TextEditingController _controllerKeterangan = TextEditingController();

  @override
  void initState(){
    if (widget.site !=null){
      _isFieldNamaValid = true;
      _controllerNama.text = widget.site.nama;
      _isFieldKeteranganValid = true;
      _controllerKeterangan.text = widget.site.keterangan;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          widget.site == null ? "Form Add" : "Change Data",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTextFieldNama(),
                _buildTextFieldKeterangan(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RaisedButton(
                    onPressed: () {
                      if (_isFieldNamaValid == null ||
                          _isFieldKeteranganValid == null ||
                          !_isFieldNamaValid ||
                          !_isFieldKeteranganValid){
                        _scaffoldState.currentState.showSnackBar(
                          SnackBar(
                            content: Text("Please fill all field"),
                          ),
                        );
                        return;
                      }
                      setState(() => _isLoading = true);
                      String nama = _controllerNama.text.toString();
                      String keterangan = _controllerKeterangan.text.toString();
                      Site site =
                      Site(nama: nama, keterangan: keterangan);
                      if (widget.site == null) {
                        _apiService.createSite(site).then((isSuccess) {
                          setState(() => _isLoading = false);
                          if (isSuccess) {
                            Navigator.pop(_scaffoldState.currentState.context);
                          } else {
                            _scaffoldState.currentState.showSnackBar(SnackBar(
                              content: Text("Submit data failed"),
                            ));
                          }
                        });
                      }
                      else {
                        site.idsite = widget.site.idsite;
                        _apiService.updatesite(site).then((isSuccess) {
                          setState(() => _isLoading = false);
                          if (isSuccess) {
                            Navigator.pop(_scaffoldState.currentState.context);
                          } else {
                            _scaffoldState.currentState.showSnackBar(SnackBar(
                              content: Text("Update data failed"),
                            ));
                          }
                        });
                      }
                    },
                    child: Text(
                      widget.site == null
                          ? "Submit".toUpperCase()
                          : "Update Data".toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.orange[600],
                  ),
                )
              ],
            ),
          ),
          _isLoading
              ? Stack(
            children: <Widget>[
              Opacity(
                opacity: 0.3,
                child: ModalBarrier(
                  dismissible: false,
                  color: Colors.grey,
                ),
              ),
              Center(
                child: CircularProgressIndicator(),
              ),
            ],
          )
              : Container(),
        ],
      ),
    );
  }

  Widget _buildTextFieldNama() {
    return TextField(
      controller: _controllerNama,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Nama",
        errorText: _isFieldNamaValid == null || _isFieldNamaValid
            ? null
            : "Isi Nama",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldNamaValid) {
          setState(() => _isFieldNamaValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldKeterangan() {
    return TextField(
      controller: _controllerKeterangan,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Keterangan",
        errorText: _isFieldKeteranganValid == null || _isFieldKeteranganValid
            ? null
            : "Isi Keterangan",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldKeteranganValid) {
          setState(() => _isFieldKeteranganValid = isFieldValid);
        }
      },
    );
  }
}