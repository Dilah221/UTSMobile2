import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Warna.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pendaftaran Dokter Hewan',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('Images/logoKecil.png', fit: BoxFit.contain,),
        backgroundColor: AppColors.HijauMuda,
        title: Text('PET CARE', style: TextStyle(color: Colors.white, fontSize: 30, ),),
        centerTitle: true,
        actions: [
          DropdownButton<String>(
            underline: Container(),
            icon: Icon(Icons.more_vert, color: Colors.white),
            items: [
              DropdownMenuItem(value: 'option1', child: Text('Option 1')),
              DropdownMenuItem(value: 'option2', child: Text('Option 2')),
            ],
            onChanged: (value) {
              Fluttertoast.showToast(
                  msg: "Anda memilih $value",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.blue,
                  textColor: Colors.white);
            },
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegisterPage()),
            );
          },
          child: Text('Daftar ke Dokter Hewan'),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (index) {
          Fluttertoast.showToast(
              msg: "Navigasi ke index $index",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM);
        },
      ),
    );
  }
}

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  List<String> items = ["Konsultasi", "Vaksin", "Cek Penyakit"];
  String? selectedItem;
  int? _selectedIndex;
    TextEditingController _controller = TextEditingController();

  void _showSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Pendaftaran berhasil!")),
    );
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Konfirmasi'),
        content: Text('Apakah Anda yakin ingin mendaftar?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Tidak')),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                _showSnackbar();
              },
              child: Text('Ya')),
        ],
      ),
    );
  }

  void _showCustomDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Custom Dialog', style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () => Navigator.pop(context), child: Text('Tutup')),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? pickedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        leading: Image.asset('Images/logoKecil.png', fit: BoxFit.contain,),
        backgroundColor: AppColors.HijauMuda,
        title: Text('PET CARE', style: TextStyle(color: Colors.white, fontSize: 30, ),),
        centerTitle: true,),
        
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          DropdownButton<String>(
            hint: Text('Jenis Pendaftaran'),
            value: selectedItem,
            items: items
                .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedItem = value;
              });
            },
          ),SizedBox(height: 20),
          Text('Jumlah Hewan', style: TextStyle(color: Colors.black, fontSize: 10),),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black, // Warna border
              width: 2, // Ketebalan border
            ),
            borderRadius: BorderRadius.circular(10), // Sudut border melengkung
          ),
            child: GridView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 10, crossAxisSpacing: 1, mainAxisSpacing: 1.0),
            itemCount: 10,
            itemBuilder: (context, index){
          bool isSelected = _selectedIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = isSelected ? null : index;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.white, 
                border: Border.all(
                  color: isSelected ? Colors.greenAccent : Colors.transparent,
                  width: 3,  // Lebar border
                ),
                borderRadius: BorderRadius.circular(8), 
              ),
              child: Center(
                child: Text(
                  '$index',
                  style: TextStyle(
                    color: isSelected ? Colors.black : Colors.black, 
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          );
        },
          ),
          ),SizedBox(height: 20),
          
          TextField(
            style: TextStyle(fontSize: 10, color: Colors.grey),
              decoration: InputDecoration(
                labelText: 'Jenis Hewan',
                hintText: 'Anjing, Kucing, ...',
                border: OutlineInputBorder(),
              ),
            ),SizedBox(height: 20),

            TextField(
              style: TextStyle(fontSize: 10, color: Colors.grey),
              decoration: InputDecoration(
                labelText: 'Umur Hewan',
                hintText: 'Masukan Umur Hewan Anda',
                border: OutlineInputBorder(),
              ),
            ),SizedBox(height: 20),

            Container(
              width: double.infinity,
              child: TextField(
                controller: _controller,maxLines: null,minLines: 1,
                style: TextStyle(fontSize: 10, color: Colors.grey),
                decoration: InputDecoration(
                  labelText: 'Kondisi Hewan',
                  hintText: 'Deskripsikan Kondisi Hewan Anda Saat Ini',
                  border: OutlineInputBorder(),
                ),
              ),),

          SizedBox(height: 10),
          Text('Pilih Tanggal Berkunjung', style: TextStyle(color: Colors.black, fontSize: 10),),
          SizedBox(height: 10),
          ElevatedButton(onPressed: _selectDate, child: Text('Pilih Tanggal')),
          if (selectedDate != null) Text("Tanggal: ${selectedDate.toString()}"),
          SizedBox(height: 10),
          ElevatedButton(onPressed: _selectTime, child: Text('Pilih Waktu')),
          if (selectedTime != null) Text("Waktu: ${selectedTime?.format(context)}"),
          SizedBox(height: 20),
          ElevatedButton(onPressed: _showAlertDialog, child: Text('Kirim')),
          SizedBox(height: 20),
          
        ],
      ),
    );
  }
}
