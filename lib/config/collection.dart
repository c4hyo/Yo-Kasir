import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// instance objek dari firebase
final auth = FirebaseAuth.instance;

// pemanggilan collection dari firestore
final profilDb = FirebaseFirestore.instance.collection("profil");
final tokoDb = FirebaseFirestore.instance.collection("toko");
final transaksiDb = FirebaseFirestore.instance.collection("transaksi");
