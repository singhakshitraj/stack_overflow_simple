import 'package:social_media/services/auth/auth_services.dart';

class PostFormat {
  // CONVERT RAW DATA FFROM USER TO FORMAT OF DATA TO BE STORE IN DATABASE.
  Map<String, dynamic> userDetails(Map<String, dynamic> toSave) {
    Map<String, dynamic> toReturn = {};
    toReturn['name'] = toSave['name'];
    toReturn['email'] =
        (toSave['email'] == null) ? AuthServices().email : toSave['email'];
    toReturn['id'] = toSave['id'];
    return toReturn;
  }
}
