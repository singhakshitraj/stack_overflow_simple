class PostFormat {
  // CONVERTS RAW-FORMAT RECIEVED FROM USER TO FORMAT OF SAVING DATA
  Map<String, dynamic> toPost(Map<String, dynamic> toUpload) {
    Map<String, dynamic> mp = {};
    mp['madeAt'] = DateTime.now().toString();
    mp['madeBy'] =
        (toUpload['madeBy'] == null) ? 'sampleUser' : toUpload['madeBy'];
    mp['content'] = toUpload['content'];
    mp['open'] = true;
    mp['upvotes'] = 0;
    mp['tags'] = (toUpload['tags'] == null)?<Map<String,dynamic>>[]: toUpload['tags'];
    return mp;
  }
}
