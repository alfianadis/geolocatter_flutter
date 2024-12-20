import 'package:flutter/material.dart';
import 'package:fluttergeo/utils/colors.dart';

class InformasiScreen extends StatefulWidget {
  const InformasiScreen({super.key});

  @override
  State<InformasiScreen> createState() => _InformasiScreenState();
}

class _InformasiScreenState extends State<InformasiScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            size: 23,
            color: AppColors.neutralColor,
          ),
        ),
        title: const Text(
          'Informasi Pemilihan Umum',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Center(
                      child: SizedBox(
                        width: 150,
                        height: 150,
                        child: Image.asset("assets/images/kpu_logo.png"),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(20),
                      height: 380,
                      width: size.width,
                      child: Container(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: const Text(
                          'Pemilihan umum adalah salah satu mekanisme demokrasi untuk memilih perwakilan rakyat serta pemimpin negara. Proses ini melibatkan seluruh warga negara yang memiliki hak suara untuk berpartisipasi dalam memilih calon yang akan duduk di kursi pemerintahan, baik di tingkat nasional maupun daerah. Pemilu mencerminkan kedaulatan rakyat dan merupakan wujud dari partisipasi aktif dalam kehidupan bernegara.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                'Ver 1.0',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
