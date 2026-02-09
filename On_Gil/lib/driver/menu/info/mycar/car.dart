import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Car extends StatefulWidget {
  const Car({super.key});

  @override
  State<Car> createState() => _CarState();
}

class _CarState extends State<Car> {
  late TextEditingController carNameController;
  late TextEditingController carNumberController;

  String carType = '승용차';
  String carSize = '중형';
  String alertDistance = '보통';
  bool isDefaultCar = false;

  @override
  void initState() {
    super.initState();
    carNameController = TextEditingController();
    carNumberController = TextEditingController();
    _loadCarInfo();
  }

  // 🔹 불러오기
  Future<void> _loadCarInfo() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      carNameController.text = prefs.getString('car_name') ?? '';
      carNumberController.text = prefs.getString('car_number') ?? '';

      carType = prefs.getString('car_type') ?? '승용차';
      carSize = prefs.getString('car_size') ?? '중형';
      alertDistance = prefs.getString('alert_distance') ?? '보통';
      isDefaultCar = prefs.getBool('is_default_car') ?? false;
    });
  }

  // 🔹 저장
  Future<void> _saveCarInfo() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('car_name', carNameController.text);
    await prefs.setString('car_number', carNumberController.text);
    await prefs.setString('car_type', carType);
    await prefs.setString('car_size', carSize);
    await prefs.setString('alert_distance', alertDistance);
    await prefs.setBool('is_default_car', isDefaultCar);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('차량 정보가 저장되었습니다')),
    );
  }

  @override
  void dispose() {
    carNameController.dispose();
    carNumberController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Color(0xFFFFC107),
          width: 2,
        ),
      ),
      labelStyle: const TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.w600,
      ),
    );
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
            fontWeight: FontWeight.bold,
            fontSize: 26,
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
              '내 차량 등록',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 20),

            // ✅ 추가된 텍스트 필드
            TextField(
              controller: carNumberController,
              decoration: _inputDecoration('소유 차량 번호'),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: carNameController,
              decoration: _inputDecoration('소유 차량 모델명'),
            ),


            const SizedBox(height: 28),

            _sectionTitle('차량 유형'),
            _selectRow(
              ['승용차', 'SUV', '화물차'],
              carType,
                  (value) => setState(() => carType = value),
            ),

            const SizedBox(height: 24),

            _sectionTitle('차량 크기'),
            _selectRow(
              ['소형', '중형', '대형'],
              carSize,
                  (value) => setState(() => carSize = value),
            ),

            const SizedBox(height: 24),

            _sectionTitle('위험 알람 거리'),
            _selectRow(
              ['가까움', '보통', '넓음'],
              alertDistance,
                  (value) => setState(() => alertDistance = value),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Checkbox(
                  value: isDefaultCar,
                  activeColor: const Color(0xFFFFC107),
                  onChanged: (value) {
                    setState(() => isDefaultCar = value ?? false);
                  },
                ),
                const Text('기본 운전 차량으로 설정'),
              ],
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: _saveCarInfo,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD25A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  '저장하기',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ===== 공통 UI =====
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _selectRow(
      List<String> items,
      String selected,
      Function(String) onSelect,
      ) {
    return Row(
      children: items.map((item) {
        final isSelected = item == selected;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: GestureDetector(
              onTap: () => onSelect(item),
              child: Container(
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFFFC107) : Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  item,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
