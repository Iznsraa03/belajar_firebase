import 'package:belajar_firebase/tambahData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Homepage extends StatelessWidget {
  final CollectionReference dataku = FirebaseFirestore.instance.collection(
    'dataku',
  );
  Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Belajar firebase')),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: dataku.snapshots(),
          builder: (context, snaphot) {
            if (snaphot.hasError) {
              return Text('Data tidak berhasil di ambil');
            }
            if (snaphot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            final data = snaphot.data!.docs;

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                var doc = data[index];
                var datas = doc.data() as Map<String, dynamic>;
                return Column(
                  children: [
                    Row(
                      children: [
                        Text(datas['nama']),
                        Gap(20),
                        Text('${datas['umur']}'),
                        Gap(20),
                        Text(datas['alamat']),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Tambahdata()),
          );
        },
        child: Icon(Icons.add_circle),
      ),
    );
  }
}
