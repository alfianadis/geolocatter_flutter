import 'package:flutter/material.dart';
import 'package:fluttergeo/screen/form_screen.dart';
import 'package:fluttergeo/screen/informasi_screen.dart';
import 'package:fluttergeo/screen/view_data_screen.dart';
import 'package:fluttergeo/utils/colors.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
            child: Column(
              children: [
                Center(
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset("assets/images/kpu_logo.png"),
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const InformasiScreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: size.height * 0.15,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: AppColors.chart01,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      children: [
                        SizedBox(width: 10),
                        Icon(
                          Icons.info,
                          color: Colors.white,
                          size: 75,
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Informasi',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Informasi Pemilihan umum',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const FormScreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: size.height * 0.15,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: AppColors.chart01,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      children: [
                        SizedBox(width: 10),
                        Icon(
                          Icons.edit_document,
                          color: Colors.white,
                          size: 75,
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Form Entry',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Form entri data calon pemilih',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ViewDataScreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: size.height * 0.15,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: AppColors.chart01,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      children: [
                        SizedBox(width: 10),
                        Icon(
                          Icons.view_list,
                          color: Colors.white,
                          size: 75,
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Lihat Data',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Informasi Data Sudah Di Input',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    // Tampilkan dialog konfirmasi sebelum keluar
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Konfirmasi Keluar"),
                          content: const Text(
                              "Apakah Anda yakin ingin keluar dari aplikasi?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Tutup dialog
                              },
                              child: const Text("Batal"),
                            ),
                            TextButton(
                              onPressed: () {
                                SystemNavigator.pop(); // Keluar dari aplikasi
                              },
                              child: const Text("Keluar"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    height: size.height * 0.15,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: AppColors.chart01,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      children: [
                        SizedBox(width: 10),
                        Icon(
                          Icons.exit_to_app,
                          color: Colors.white,
                          size: 75,
                        ),
                        SizedBox(width: 20),
                        Text(
                          'Keluar',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
