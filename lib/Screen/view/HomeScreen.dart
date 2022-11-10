import 'package:cashbook/Screen/dbHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../controller/HomeController.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  TextEditingController txtname = TextEditingController();
  TextEditingController txtmobile = TextEditingController();
  TextEditingController txtadd = TextEditingController();
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  Future<void> getdata() async {
    DbHelper db = DbHelper();
    homeController.customerList.value = await db.readData();
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("My Business", style: TextStyle(fontSize: 17)),
        leading: Icon(Icons.book_outlined),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[Color(0xff487eea), Color(0xff3564cc)]),
          ),
        ),
      ),
      backgroundColor: Color(0xfff3f3f3),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 4, top: 8, bottom: 8, left: 8),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xffdcfff9),
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "\u{20B9} 1000",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff0b9e84),
                              ),
                            ),
                            Text(
                              "You will get",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff0b9e84),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 8, top: 8, bottom: 8, left: 4),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xffffe9ec),
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "\u{20B9} 1000",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffdf2f3a),
                              ),
                            ),
                            Text(
                              "You will give",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffdf2f3a),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: TextField(
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none),
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                        prefixIcon: Container(
                          padding: EdgeInsets.all(15),
                          child: Icon(Icons.search),
                          width: 18,
                        )),
                  ),
                ),
              ],
            ),
            Obx(
              () => ListView.builder(
                  itemCount: homeController.customerList.value.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                          "${homeController.customerList.value[index]['name']}"),
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.defaultDialog(
              title: ("Customer Details"),
              content: Column(
                children: [
                  TextField(
                    controller: txtname,
                    decoration: InputDecoration(hintText: "Name"),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  IntlPhoneField(
                    controller: txtmobile,
                    decoration: InputDecoration(
                      hintText: 'Phone Number',
                    ),
                    initialCountryCode: 'IN',
                    onChanged: (phone) {
                      print(phone.completeNumber);
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: txtadd,
                    decoration: InputDecoration(hintText: "Address"),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        DbHelper db = DbHelper();
                        db.datainsert(
                            txtname.text, txtmobile.text, txtadd.text);
                        getdata();
                      },
                      child: Text("Submit"))
                ],
              ));
        },
        icon: Icon(Icons.person_add),
        label: Text("ADD CUSTOMER"),
        backgroundColor: Color(0xff3564cc),
      ),
    ));
  }
}
