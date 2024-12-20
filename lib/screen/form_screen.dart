import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:fluttergeo/Data/helper.dart';
import 'package:fluttergeo/Data/kpu_model.dart';
import 'package:fluttergeo/screen/home_screen.dart';
import 'package:fluttergeo/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nomorhpController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  String selectedDate = '';
  String? selectedGender;
  String _currentAddress = '';

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

//fungsi cek layanan lokasi gps perangkat aktif atau tidak
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

//fungsi untuk mendapatkan lat dan long, dan diubah menjadi alamat
  Future<void> _getAddressFromLatLng(Position position) async {
    try {
      //get posisi lat dan long
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
//merubah menjadi teks alamat
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            "${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

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
          'Form Penambahan Data',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                'NIK',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: size.height * 0.09,
                width: size.width,
                decoration: BoxDecoration(
                  color: AppColors.greenSecobdColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 8),
                  child: TextFormField(
                    controller: _nikController,
                    onChanged: (value) {},
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Masukkan NIK Anda",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 12,
                          color: AppColors.greySixColor),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Nama',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: size.height * 0.09,
                width: size.width,
                decoration: BoxDecoration(
                  color: AppColors.greenSecobdColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 8),
                  child: TextFormField(
                    controller: _nameController,
                    onChanged: (value) {},
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Masukkan Nama Anda",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 12,
                          color: AppColors.greySixColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'No Handphone',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: size.height * 0.09,
                width: size.width,
                decoration: BoxDecoration(
                  color: AppColors.greenSecobdColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 8),
                  child: TextFormField(
                    controller: _nomorhpController,
                    onChanged: (value) {},
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Masukkan Nomor Handphone",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 12,
                          color: AppColors.greySixColor),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Jenis Kelamin',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: const Text(
                        'Laki-laki',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      leading: Radio<String>(
                        value: 'Laki-Laki',
                        groupValue: selectedGender,
                        onChanged: (String? value) {
                          setState(() {
                            selectedGender = value;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text(
                        'Perempuan',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      leading: Radio<String>(
                        value: 'Perempuan',
                        groupValue: selectedGender,
                        onChanged: (String? value) {
                          setState(() {
                            selectedGender = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Tanggal',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime
                        .now(), // Membatasi pemilihan tanggal hingga hari ini
                  );

                  if (pickedDate != null) {
                    setState(() {
                      selectedDate =
                          "${pickedDate.year.toString().padLeft(4, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                    });
                  }
                },
                child: Container(
                  height: size.height * 0.09,
                  width: size.width,
                  padding: const EdgeInsets.only(left: 20, right: 25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.greenSecobdColor,
                    border: Border.all(
                      color: AppColors.greySecondColor,
                      width: 2.0,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: size.width * 0.62,
                        child: Text(
                          selectedDate.isNotEmpty
                              ? selectedDate
                              : 'Masukkan Tanggal',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: selectedDate.isNotEmpty
                                ? FontWeight.bold
                                : FontWeight.w200,
                            color: selectedDate.isNotEmpty
                                ? AppColors.neutralColor
                                : AppColors.greySixColor,
                          ),
                        ),
                      ),
                      selectedDate.isNotEmpty
                          ? InkWell(
                              onTap: () {
                                setState(() {
                                  selectedDate = '';
                                });
                              },
                              child: SvgPicture.asset(
                                'assets/icons/cross.svg',
                                width: 20,
                                height: 20,
                                color: AppColors.neutralColor,
                              ),
                            )
                          : SvgPicture.asset(
                              'assets/icons/arrow-down.svg',
                              width: 15,
                              height: 15,
                              color: AppColors.neutralColor,
                            ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Alamat',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: size.height * 0.15,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 8),
                      child: TextFormField(
                        controller: _addressController,
                        onChanged: (value) {
                          setState(() {});
                        },
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: _addressController.text.isNotEmpty
                              ? Colors.black
                              : Colors.grey,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: _currentAddress.isEmpty
                              ? "Masukkan Alamat Anda"
                              : _currentAddress,
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 12,
                            color: _currentAddress.isEmpty
                                ? Colors.grey
                                : Colors.black,
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        maxLines: 2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: size.width * 0.3,
                    height: size.height * 0.05,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.blue,
                    ),
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () async {
                        Position position = await _determinePosition();
                        await _getAddressFromLatLng(position);
                        setState(() {
                          _addressController.text = _currentAddress;
                        });
                      },
                      child: const Center(
                        child: Text(
                          'Cari Lokasi',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Gambar',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.camera_alt),
                          title: const Text('Ambil Foto'),
                          onTap: () {
                            Navigator.pop(context);
                            _pickImage(ImageSource.camera);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.photo_library),
                          title: const Text('Pilih dari Galeri'),
                          onTap: () {
                            Navigator.pop(context);
                            _pickImage(ImageSource.gallery);
                          },
                        ),
                      ],
                    ),
                  );
                },
                child: SizedBox(
                  height: size.height * 0.3,
                  width: size.width * 0.4,
                  child: Container(
                    color: Colors.white,
                    child: DottedBorder(
                      padding: const EdgeInsets.all(8),
                      radius: const Radius.circular(8),
                      borderType: BorderType.RRect,
                      strokeWidth: 0.5,
                      color: const Color(0xffC4C4C4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: _imageFile == null
                                  ? Container(
                                      width: size.width * 0.1,
                                      height: size.width * 0.1,
                                      decoration: BoxDecoration(
                                        color: AppColors.greenColor,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.add,
                                          color: AppColors.bgColor,
                                        ),
                                      ),
                                    )
                                  : Image.file(
                                      _imageFile!,
                                      height: size.height * 0.3,
                                      width: size.width * 0.4,
                                      fit: BoxFit.contain,
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              //button submit
              Center(
                child: Container(
                  width: size.width * 0.8,
                  height: size.height * 0.07,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.black,
                  ),
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () async {
                      try {
                        FormData formData = FormData(
                          nik: _nikController.text,
                          name: _nameController.text,
                          phone: _nomorhpController.text,
                          gender: selectedGender ?? '',
                          date: selectedDate,
                          address: _addressController.text,
                          imagePath: _imageFile?.path ?? '',
                        );

                        await DatabaseHelper.instance.insertFormData(formData);

                        // Tampilkan alert berhasil
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Berhasil"),
                            content: const Text("Data berhasil disimpan!"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const HomeScreen(),
                                    ),
                                  );
                                },
                                child: const Text("OK"),
                              ),
                            ],
                          ),
                        );
                      } catch (e) {
                        // Tampilkan alert gagal
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Gagal"),
                            content: Text(
                                "Terjadi kesalahan saat menyimpan data: $e"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // Menutup dialog
                                },
                                child: const Text("OK"),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    child: const Center(
                      child: Text(
                        'Submit Data',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: AppColors.whiteTextColor),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
