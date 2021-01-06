import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:pro/models/post_model.dart';
class RTDBService{
  static const _dburl="https://pro-1c00f-default-rtdb.firebaseio.com/";

  static final _database=FirebaseDatabase.instance.reference(_dburl);

  static Future<Stream<Event>> addPost(Post post)async{
    _database.child("posts").push().set(post.toJson());
    return _database.onChildAdded;
  }
  static Future<List<Post>> getPost(String id) async{
    List<Post> items=new List();
    Query _query=_database.reference().child("posts").orderByChild("userId").equalTo(id);
    var snapshot=await _query.once();
    var result=snapshot.value as Iterable;

    for(var item in result){
      items.add(Post.fromJson(Map<String,dynamic>.from(item)));
    }
    return items;
  }
}