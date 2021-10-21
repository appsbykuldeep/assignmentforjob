import 'package:assignmentforjob/models/listdata_model.dart';
import 'package:assignmentforjob/widget/listtile_widget.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

final Color blackcolor = Colors.black;
final Color lightblackcolor = Colors.black54;

class _ListScreenState extends State<ListScreen> {
  var apidata = <ListDataModel>[].obs;
  var islastpage = false;
  var pagecount = 0;
  var isloading = false.obs;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * .85) {
        if (islastpage || isloading.value) return;
        getapidata();
      }
    });
    getapidata();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<bool> getapidata() async {
    try {
      isloading.value = true;
      String _url =
          "https://api.github.com/users/JakeWharton/repos?page=$pagecount&per_page=15";
      http.Response response = await http.get(Uri.parse(_url));
      if (response.statusCode == 200) {
        final _newdata = listDataModelFromJson(response.body);
        apidata.addAll(_newdata);
        pagecount++;
        if (_newdata.isEmpty) islastpage = true;
        isloading.value = false;
        return true;
      }
    } catch (e) {
      debugPrint("getapidata : $e");
    }
    isloading.value = false;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: lightblackcolor,
          title: "Kuldeep's App"
              .text
              .white
              .size(18)
              .fontWeight(FontWeight.w600)
              .make(),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          child: Obx(() => Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if ((pagecount == 0 && isloading.value)) buildlineindicator(),
                  ...List.generate(
                    apidata.length,
                    (index) => ListCard(onedata: apidata[index]),
                  ),
                  Visibility(
                      visible: (isloading.value &&
                          !islastpage &&
                          apidata.isNotEmpty),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: builcircleindicater(),
                      )),
                ],
              )),
        ),
      ),
    );
  }

  Widget builcircleindicater() {
    return Center(
      child: CircularProgressIndicator(
        color: blackcolor,
      ),
    );
  }

  Widget buildlineindicator() {
    return LinearProgressIndicator(
      color: blackcolor,
    );
  }
}
