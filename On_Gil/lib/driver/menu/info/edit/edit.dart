import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:on_gil/driver/menu/info/mycar/car.dart';

class Edit extends StatefulWidget {
  const Edit({super.key});

  @override
  State<Edit> createState() => _EditCar();
}

class _EditCar extends State<Edit> {
  late TextEditingController carNameController;
  late TextEditingController carNumberController;
  late TextEditingController carTypeController;
  late TextEditingController alertDistanceController;
  late TextEditingController carSizeController;
  bool isLoading = true;


  String carName = '모델명을 등록해주세요.';
  String carNumber = '차량번호를 등록해주세요.';
  String carType = '화물차';
  String alertDistance = '설정되지 않음';
  String carSize = '설정되지 않음';


  @override
  void initState() {
    super.initState();
    carNameController = TextEditingController();
    carNumberController = TextEditingController();
    carTypeController = TextEditingController();
    alertDistanceController = TextEditingController();
    carSizeController = TextEditingController();
    _loadCarInfo();
  }

  Future<void> _loadCarInfo() async {
    await Future.delayed(const Duration(seconds: 1));

    final prefs = await SharedPreferences.getInstance();
    setState(() {
      carName = prefs.getString('car_name') ?? carName;
      carNumber = prefs.getString('car_number') ?? carNumber;
      carType = prefs.getString('car_type') ?? carType;
      alertDistance = prefs.getString('alert_distance') ?? alertDistance;
      carSize = prefs.getString('car_size') ?? carSize;


      carNameController.text = carName;
      carNumberController.text = carNumber;
      carTypeController.text = carType;
      alertDistanceController.text = alertDistance;
      carSizeController.text = carSize;
      isLoading = false;


    });
  }

  Future<void> _saveCarInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('car_name', carNameController.text);
    await prefs.setString('car_number', carNumberController.text);
    await prefs.setString('car_type', carTypeController.text);
    await prefs.setString('alert_distance', alertDistanceController.text);
    await prefs.setString('car_size', carSizeController.text);


    setState(() {
      carName = carNameController.text;
      carNumber = carNumberController.text;
      carType = carTypeController.text;
      alertDistance = alertDistanceController.text;
      carSize = carSizeController.text;
    });
  }

  @override
  void dispose() {
    carNameController.dispose();
    carNumberController.dispose();
    carTypeController.dispose();
    alertDistanceController.dispose();
    carSizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'On-Gil',
          style: TextStyle(
            color: Color(0xFFFFC107),
            fontSize: 26,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter'
          ),
        ),
      ),
      body: isLoading
      ? const Center(
      child: CircularProgressIndicator(
      color: Color(0xFFFFC107),
    ),
    )
        : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              '내 차량',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 20),
            _carCard(),
          ],
        ),
      ),
    );
  }

  Widget _carCard() {
    final isLightMode = Theme.of(context).brightness == Brightness.light;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isLightMode ? Colors.white : Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            carType,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 4),
          Text(
            '$carName · $carNumber',
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: _showEditDialog,
                  child: _grayButton('수정'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: _showDetailDialog,
                  child: _yellowButton('상세 정보 보기'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }


  Widget _grayButton(String text) =>
      Container(
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFFE0E0E0),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Text(
            text,
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold
            )
        ),
      );

  Widget _yellowButton(String text) =>
      Container(
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFFFFC107),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Text(
            text,
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold
            )
        ),
      );



  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (_) =>
          AlertDialog(
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            contentTextStyle: TextStyle(
              color: Colors.black,
          ),
            title: Text(
              '차량 정보 수정',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _editRow('차량 유형', carTypeController),
                const SizedBox(height: 8),
                _editRow('차량 모델', carNameController),
                const SizedBox(height: 8),
                _editRow('차량 번호', carNumberController),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  '취소',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  await _saveCarInfo();
                  Navigator.pop(context);
                },
                child: const Text(
                  '저장',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
    );
  }

  Widget _editRow(String label, TextEditingController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
        ),
        Expanded(
          child: TextField(
            controller: controller,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            cursorColor: Colors.black,
            decoration: const InputDecoration(
              isDense: true,
              border: InputBorder.none,
              hintText: '',
              hintStyle: TextStyle(color: Colors.black38),
            ),
          ),
        ),
      ],
    );
  }

  void _showDetailDialog() {
    showDialog(context: context,
      builder: (_) =>
          AlertDialog(
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            contentTextStyle: TextStyle(
              color: Colors.black,
            ),
            title: Text(
              '차량 상세 정보',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _detailRow('차량 유형', carType),
                const SizedBox(height: 8),
                _detailRow('차량 모델', carName),
                const SizedBox(height: 8),
                _detailRow('차량 번호', carNumber),
                const SizedBox(height: 8),
                _detailRow('차량 크기', carSize),
                const SizedBox(height: 8),
                _detailRow('위험 알람 거리', alertDistance),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  '닫기',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

}