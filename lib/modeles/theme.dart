import 'package:flutter/material.dart';

class theme extends StatefulWidget {
  static String tag = "/theme";

  @override
  _themeState createState() => _themeState();
}

class _themeState extends State<theme> {
  @override
  void initState() {
    super.initState();
  }

  init() async {}

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: appStore.appBarColor,
            iconTheme: IconThemeData(color: appStore.iconColor),
            title: Text('Partnership in Innovation, Science, and Technology for Saving Lives', style: TextStyle(color: appStore.textPrimaryColor, fontSize: 20,fontWeight: FontWeight.bold)),
            bottom: TabBar(
              onTap: (index) {
                print(index);
              },
              labelStyle: const TextStyle(fontSize: 16),
              indicatorColor: Colors.blue,
              physics:const BouncingScrollPhysics(),
              labelColor: appStore.textPrimaryColor,
              tabs:const [
                  Tab(
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      
                      SizedBox(width: 5,),
                      Text(
                        'theme 1',
                      ),
                    ],
                  ),
                ),
                 Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                     
                      SizedBox(width: 5,),
                      Text(
                        'theme 2',
                      ),
                    ],
                  ),
                ),
                Tab(
                  
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      
                      SizedBox(width: 5,),
                      Text(
                        'theme 3',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              SingleChildScrollView(
                child: Container(
                  padding:const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  width: width,
                  child: Column(
                    
                    children: [
                        Image.asset('assets/images/img.jpg',
                        height: 250,
                        width: double.infinity,),
                        const SizedBox(
                        height: 5,
                      ),
                     const  Text(
                        'Healthy Local Products and Culinary Heritage',
                        style: TextStyle(color: Colors.blue, fontSize: 24),
                      ),
                      const SizedBox(height: 15,),
                      const Text("showcases Tunisia’s rich culinary traditions and commitment to health through its diverse and nutritious local products. Visitors will explore the unique flavors of Tunisia, from olive oil and dates to spices and grains, all celebrated for their health benefits. The pavilion will also highlight how traditional Tunisian recipes have been passed down through generations, blending history with innovation in modern cuisine. This theme not only celebrates Tunisia’s vibrant food culture but also underscores its dedication to promoting healthy eating and sustainable agriculture.",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                     const SizedBox(height: 10,),
                     const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [],
                      )
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  padding:const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  width: width,
                  child: Column(
                   
                    children: [
                        Image.asset('assets/images/zaghouin.jpg',
                        height: 250,
                        width: double.infinity,),
                     const Text(
                        'Water Resource Management and Optimization',
                        style: TextStyle(color: Colors.blue, fontSize: 24),
                      ),
                      const SizedBox(height: 15,),
                     const Text(style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),"Emphasizes Tunisia’s innovative strategies in addressing water scarcity. Tunisia, a country with limited water resources, has long been a leader in sustainable water management. The pavilion will highlight cutting-edge technologies and practices that optimize water use, from advanced irrigation systems to water recycling and desalination projects. Visitors will gain insight into how Tunisia balances its agricultural needs with environmental conservation, ensuring water availability for future generations. This theme underscores Tunisia’s commitment to sustainable development and its proactive approach to overcoming global water challenges."),
                    const  SizedBox(height: 15,),
                      
                    const  Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [],
                      )
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  width: width,
                  child: Column(
                  
                    children: [
                      Image.asset('assets/images/tunis_dubai.jpg',
                      height: 250,
                      width: double.infinity,),
                      const Text(
                        'Advances in Science and Medicine',
                        style: TextStyle(color: Colors.blue, fontSize: 24),
                      ),
                      const SizedBox(height: 15,),
                      const Text(style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),"highlights Tunisia’s pioneering role in scientific research and medical innovation. The pavilion will showcase groundbreaking achievements in areas such as biotechnology, pharmaceuticals, and public health. Visitors will discover how Tunisia leverages cutting-edge technology and research to address global health challenges. The exhibit will also celebrate Tunisia’s rich history in medicine, from traditional practices to modern advancements, emphasizing the country’s commitment to improving lives through science and innovation. This forward-looking approach reflects Tunisia’s dedication to building a healthier, more sustainable future"),
                    const  SizedBox(height: 15,),
                     const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
AppStore appStore = AppStore();
class AppStore{

  Color? textPrimaryColor;
  Color? iconColorPrimaryDark;
  Color? scaffoldBackground;
  Color? backgroundColor;
  Color? backgroundSecondaryColor;
  Color? appColorPrimaryLightColor;
  Color? textSecondaryColor;
  Color? appBarColor;
  Color? iconColor;
  Color? iconSecondaryColor;
  Color? cardColor;

  AppStore() {

    textPrimaryColor = const Color(0xFF212121);
    iconColorPrimaryDark =const Color(0xFF212121);
    scaffoldBackground =const Color(0xFFEBF2F7);
    backgroundColor = Colors.black;
    backgroundSecondaryColor =const Color(0xFF131d25);
    appColorPrimaryLightColor = const Color(0xFFF9FAFF);
    textSecondaryColor =const Color(0xFF5A5C5E);
    appBarColor = Colors.white;
    iconColor =const Color(0xFF212121);
    iconSecondaryColor =const Color(0xFFA8ABAD);
    cardColor =const Color(0xFF191D36);

  }
}