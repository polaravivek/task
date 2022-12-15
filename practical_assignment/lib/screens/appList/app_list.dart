import 'package:flutter/material.dart';
import 'package:practical_assignment/models/freeAppModel.dart';
import 'package:practical_assignment/services/remote_services.dart';
import 'package:styled_widget/styled_widget.dart';

class AppListScreen extends StatefulWidget {
  const AppListScreen({Key? key}) : super(key: key);

  @override
  State<AppListScreen> createState() => _AppListScreenState();
}

class _AppListScreenState extends State<AppListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabBarController;
  List<FreeAppApi>? _freeAppList = [];
  List<FreeAppApi>? _paidAppList = [];
  List<FreeAppApi>? _copyFreeAppList = [];
  List<FreeAppApi>? _copyPaidAppList = [];

  @override
  void initState() {
    _tabBarController = TabController(length: 2, vsync: this);
    super.initState();

    getData();
  }

  Future getData() async {
    _freeAppList = (await RemoteService(
            url:
                "https://rss.applemarketingtools.com/api/v2/us/apps/top-free/50/apps.json")
        .getFreeAppList())!;
    _copyFreeAppList = _freeAppList;
    _paidAppList = (await RemoteService(
            url:
                "https://rss.applemarketingtools.com/api/v2/us/apps/top-paid/50/apps.json")
        .getFreeAppList())!;
    _copyPaidAppList = _paidAppList;
    if (_freeAppList != null) {
      setState(() {});
    }
    if (_paidAppList != null) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _tabBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 225, 225, 225),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 225, 225, 225),
          title: const Text(
            'App List',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ).center(),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  _freeAppList = _copyFreeAppList!
                      .where((element) =>
                          element.name!.toLowerCase().contains(value))
                      .toList();
                  _paidAppList = _copyPaidAppList!
                      .where((element) =>
                          element.name!.toLowerCase().contains(value))
                      .toList();
                });
              },
              style: const TextStyle(
                  color: Color.fromARGB(255, 95, 95, 95), fontSize: 16),
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search,
                      color: Color.fromARGB(255, 95, 95, 95)),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 198, 198, 198),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 198, 198, 198),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.grey, width: 0),
                  ),
                  contentPadding: const EdgeInsets.only(left: 25),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  hintText: const Text(
                    'Search',
                  ).data,
                  suffixIcon: const Icon(Icons.mic,
                      color: Color.fromARGB(255, 95, 95, 95))),
            ).padding(horizontal: 10),
            const SizedBox(height: 10),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 198, 198, 198),
                ),
                child: TabBar(
                  physics: const BouncingScrollPhysics(),
                  indicatorWeight: 1,
                  indicatorPadding: const EdgeInsets.symmetric(vertical: 5),
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  labelColor: Colors.black,
                  labelStyle: const TextStyle(fontSize: 14),
                  // unselectedLabelStyle: TextStyle(fontSize: 14),
                  labelPadding: const EdgeInsets.symmetric(vertical: 10),
                  // unselectedLabelColor: Colors.black26,
                  tabs: const [
                    Text(
                      'Top Free',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Top Paid',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                  controller: _tabBarController,
                ).center(),
              ),
            ),
            TabBarView(
              controller: _tabBarController,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  color: Colors.white,
                  child: Visibility(
                    visible: _freeAppList != null,
                    child: ListView.builder(
                      itemCount: _freeAppList?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          leading: Stack(
                            children: [
                              Image.network(_freeAppList![index]
                                      .artworkUrl100
                                      .toString())
                                  .clipRRect(all: 10)
                                  .padding(all: 5),
                              Positioned(
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  child: Text('${index + 1}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w900))
                                      .center(),
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlue,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                top: 0,
                                left: 0,
                              ),
                            ],
                          ),
                          title: (_freeAppList != null)
                              ? Text(_freeAppList![index].name.toString())
                              : const Text("not found"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              (_freeAppList != null)
                                  ? Text(
                                      _freeAppList![index]
                                          .artistName
                                          .toString(),
                                      style: const TextStyle(fontSize: 12))
                                  : const Text("not found"),
                              (_freeAppList != null)
                                  ? (_freeAppList![index].genres != null &&
                                          _freeAppList![index]
                                              .genres!
                                              .isNotEmpty)
                                      ? Text(
                                          _freeAppList![index]
                                              .genres![0]
                                              .name
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.blueAccent))
                                      : const Text("not found")
                                  : const Text("not found"),
                            ],
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.grey,
                            size: 15,
                          ),
                        ).padding(bottom: 10, top: 10);
                      },
                    ),
                    replacement: const CircularProgressIndicator().center(),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  color: Colors.white,
                  child: Visibility(
                    visible: _paidAppList != null,
                    child: ListView.builder(
                      itemCount: _paidAppList?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          leading: Stack(
                            children: [
                              Image.network(_paidAppList![index]
                                      .artworkUrl100
                                      .toString())
                                  .clipRRect(all: 10)
                                  .padding(all: 5),
                              Positioned(
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  child: Text('${index + 1}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w900))
                                      .center(),
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlue,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                top: 0,
                                left: 0,
                              ),
                            ],
                          ),
                          title: (_paidAppList != null)
                              ? Text(_paidAppList![index].name.toString())
                              : const Text("not found"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              (_paidAppList != null)
                                  ? Text(
                                      _paidAppList![index]
                                          .artistName
                                          .toString(),
                                      style: const TextStyle(fontSize: 12))
                                  : const Text("not found"),
                              (_paidAppList != null)
                                  ? (_paidAppList![index].genres != null &&
                                          _paidAppList![index]
                                              .genres!
                                              .isNotEmpty)
                                      ? Text(
                                          _paidAppList![index]
                                              .genres![0]
                                              .name
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.blueAccent))
                                      : const Text("not found")
                                  : const Text("not found"),
                            ],
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.grey,
                            size: 15,
                          ),
                        ).padding(bottom: 10, top: 10);
                      },
                    ),
                    replacement: const CircularProgressIndicator().center(),
                  ),
                ),
              ],
            ).expanded(),
          ],
        ),
      ),
    );
  }
}
