import 'package:maintenace/model/site.dart';
import 'package:http/http.dart' show Client;

class ApiService {
  final String baseUrl = "http://192.168.6.133:3000";
  Client client = Client();

  Future<List<Site>> getSites() async {
    final response = await client.get("$baseUrl/site");
    if (response.statusCode == 200) {
      return siteFromJson(response.body);
    }
    else{
      return null;
    }
  }

  Future<bool> createSite(Site data) async {
    final response = await client.post(
      "$baseUrl/src.site",
      headers: {"content-type": "application/json"},
      body: siteToJson(data),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updatesite(Site  data) async{
    final response = await client.put("$baseUrl/site/${data.idsite}",
    headers: {"content-type": "application/json"},
    body: siteToJson(data),
    );
    if (response.statusCode == 200){
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteSite(int idsite) async {
    final response = await client.delete(
      "$baseUrl/site/$idsite",
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
