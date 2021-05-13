import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_example/domain/auth/i_auth_facade.dart';
import 'package:flutter_example/domain/core/errors.dart';
import 'package:flutter_example/presentation/injection.dart';

extension FirestoreX on FirebaseFirestore {
  Future<DocumentReference> userDocument() async {
    // 다음 처럼 같은 레이어 안에 있는 기능 가져와 사용하는것은 가능
    // lazySingleton 이기 때문에 leak 도 없음
    final userOption = await getIt<IAuthFacade>().getSignedInUser();
    // 로그인 된 유저가 없을 경우 : 로직을 잘못 짰기 때문에 앱 crash 시킴 => 문제 해결 위해
    final user = userOption.getOrElse(() => throw NotAuthenticatedError());
    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.id.getOrCrash());
  }
}

// document reference extension : Note Collection 가져오는 extension
extension DocumentReferenceX on DocumentReference {
  CollectionReference get noteCollection => collection('notes');
}
