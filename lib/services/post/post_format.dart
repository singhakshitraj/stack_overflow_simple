import 'package:social_media/services/auth/auth_services.dart';

class PostFormat {
  // CONVERTS RAW-FORMAT RECEIVED FROM USER TO FORMAT OF SAVING DATA
  Map<String, dynamic> toPost(Map<String, dynamic> toUpload) {
    Map<String, dynamic> mp = {};
    mp['madeAt'] = DateTime.now().toString();
    mp['madeBy'] = (AuthServices().currentUser?.displayName == null)
        ? 'guest'
        : AuthServices().currentUser?.displayName;
    mp['content'] = toUpload['content'];
    mp['open'] = true;
    mp['upvotes'] = 0;
    mp['tags'] = (toUpload['tags'] == null)
        ? <Map<String, dynamic>>[]
        : toUpload['tags'];
    mp['comments'] = <Map<String, dynamic>>[];
    return mp;
  }

  Map<String, dynamic> toComment(Map<String, dynamic> toComment) {
    Map<String, dynamic> comment = {};
    comment['madeBy'] = (AuthServices().currentUser?.displayName == null)
        ? 'guest'
        : AuthServices().currentUser?.displayName;
    comment['madeAt'] = DateTime.now().toString();
    comment['content'] = toComment['content'];
    return comment;
  }
}
