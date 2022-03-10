import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final auth = FirebaseAuth.instance;
final profilDb = FirebaseFirestore.instance.collection("profil");
final tokoDb = FirebaseFirestore.instance.collection("toko");
