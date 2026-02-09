import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Edit extends StatefulWidget {
  const Edit({super.key});

  @override
  State<Edit> createState() => _EditCar();
}

class _EditCar extends State<Edit> {
  late TextEditingController carNameController;
  late TextEditingController carNumberController;
  late TextEditingController carTypeController;

  String carName = '모델명을 등록해주세요.';
  String carNumber = '차량번호를 등록해주세요.';
  String carType = '화물차';

  @override
  void initState() {
    super.initState();
    carNameController = TextEditingController();
    carNumberController = TextEditingController();
    carTypeController = TextEditingController();
    _loadCarInfo();
  }

  Future<void> _loadCarInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      carName = prefs.getString('car_name') ?? carName;
      carNumber = prefs.getString('car_number') ?? carNumber;
      carType = prefs.getString('car_type') ?? carType;

      carNameController.text = carName;
      carNumberController.text = carNumber;
      carTypeController.text = carType;
    });
  }

  Future<void> _saveCarInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('car_name', carNameController.text);
    await prefs.setString('car_number', carNumberController.text);
    await prefs.setString('car_type', carTypeController.text);

    setState(() {
      carName = carNameController.text;
      carNumber = carNumberController.text;
      carType = carTypeController.text;
    });
  }

  @override
  void dispose() {
    carNameController.dispose();
    carNumberController.dispose();
    carTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F2ED),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F2ED),
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
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              '내 차량 목록',
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
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// 🔹 차종 (화물차)
          Text(
            carType,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          /// 🔹 여기!! 화물차 밑 작은 글씨
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
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
      );

  Widget _yellowButton(String text) =>
      Container(
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFFFFC107),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
      );


  /// 🔹 상세 정보 보기 (읽기 전용)
  /// 🔹 수정 다이얼로그 (상세 정보 UI와 동일한 스타일)
  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (_) =>
          AlertDialog(
            backgroundColor: const Color(0xFFF4F2ED),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text(
              '차량 정보 수정',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _editRow('차종', carTypeController),
                const SizedBox(height: 12),
                _editRow('모델명', carNameController),
                const SizedBox(height: 12),
                _editRow('차량 번호', carNumberController),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  '취소',
                  style: TextStyle(color: Colors.black, fontSize: 13),
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
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
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
          width: 70,
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 13,
            ),
          ),
        ),
        Expanded(
          child: TextField(
            controller: controller,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
            decoration: const InputDecoration(
              isDense: true,
              border: InputBorder.none,
              hintText: '',
            ),
          ),
        ),
      ],
    );
  }

  /// 🔹 상세 정보 보기 (읽기 전용)
  void _showDetailDialog() {
    showDialog(
      context: context,
      builder: (_) =>
          AlertDialog(
            backgroundColor: const Color(0xFFF4F2ED),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text(
              '차량 상세 정보',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _detailRow('차종', carType),
                const SizedBox(height: 12),
                _detailRow('모델명', carName),
                const SizedBox(height: 12),
                _detailRow('차량 번호', carNumber),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  '닫기',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
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
          width: 70,
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 13,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

}