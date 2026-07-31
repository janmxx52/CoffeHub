import '../../core/constants/firestore_constants.dart';
import '../firebase/firestore_service.dart';
import '../models/user_model.dart';

class UserRepository {
  final FirestoreService _firestore = FirestoreService.instance;

  /// Tạo người dùng
  Future<void> createUser(UserModel user) async {
    await _firestore.setDocument(
      collection: FirestoreConstants.users,
      documentId: user.uid,
      data: user.toMap(),
    );
  }

  /// Lấy thông tin người dùng
  Future<UserModel?> getUserById(String uid) async {
    final doc = await _firestore.getDocument(
      collection: FirestoreConstants.users,
      documentId: uid,
    );

    if (!doc.exists) {
      return null;
    }

    return UserModel.fromMap(doc.data()!);
  }

  /// Cập nhật người dùng
  Future<void> updateUser(UserModel user) async {
    await _firestore.updateDocument(
      collection: FirestoreConstants.users,
      documentId: user.uid,
      data: user.toMap(),
    );
  }

  /// Xóa người dùng
  Future<void> deleteUser(String uid) async {
    await _firestore.deleteDocument(
      collection: FirestoreConstants.users,
      documentId: uid,
    );
  }

  /// Kiểm tra tồn tại
  Future<bool> exists(String uid) async {
    final doc = await _firestore.getDocument(
      collection: FirestoreConstants.users,
      documentId: uid,
    );

    return doc.exists;
  }
}