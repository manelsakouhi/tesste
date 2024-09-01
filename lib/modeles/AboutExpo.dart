import 'package:flutter/material.dart';

class Expo extends StatelessWidget {


 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("About Expo"),
        centerTitle: true,

      ),
      body: SingleChildScrollView(
        
          child: Column(
            children: [
             const Text("L'Expo", style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromARGB(255, 10, 131, 231)),),
               const Text("En 2020, le dossier d’enregistrement de l’Expo 2025 Osaka,Kansai, Japon fut approuvé par l’Assemblée Générale du Bureau International des Expositions (BIE), alors que la pandémie de la Covid-19 faisait mondialement rage forçant le monde entier à faire face à une crise mondiale sans précédentDepuis, le monde doit désormais affronter de nouveaux défis, tels que la fragmentation des interactions entre les nations et les peuples, la nécessité de reconstruire les environnements et les différents systèmes sociaux et de modifier les paradigmes de la vie quotidienne. Ces circonstances nécessitent de rassembler la sagesse du monde et d’ouvrir la voie à de rapides solutions.Réfléchir au thème de l'Expo 2025 Osaka Kansai, « Concevoir la Société du Futur, Imaginer Notre Vie de Demain » et prendre les mesures nécessaires sont devenus missions dans cette nouvelle ère. La communauté internationale a par ailleurs consacré d’importants efforts à la réalisation des Objectifs de Développement Durable (ODD) d'ici 2030  et ces efforts sont en ligne avec la pertinence de l'Exposition.Les ODD sont essentiellement divers défis de la vie inextricablement liés. Tout effort pour atteindre ces objectifs doit être fait par le biais de la collaboration, rassemblant ceux qui visent à créer un avenir et des vies meilleurs et un monde naturel et humain plus durable.L’Expo 2025 Osaka Kansai offrira au monde l'occasion de se réunir en un lieu unique afin d’explorer le thème de la « vie ». Cette Exposition facilitera les interactions entre des individus du monde entier, pour créer de nouveaux réseaux humains et des projets créatifs. L’Expo 2025 Osaka Kansai partagera avec le monde entier les espoirs d'un avenir meilleur. Pour ce faire, il faudra surmonter la crise mondiale actuelle, protéger la vie et poursuivre la réflexion sur la vie et les modes de vie."),
                Image.asset("assets/images/Expo_jp.jpg",
                width: double.infinity,
                height: 200,),
              const  Padding(padding: EdgeInsets.only(top: 8)), 
             const Text("Le thème", style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromARGB(255, 10, 131, 231)),),
      
               const Text("Concevoir la Société du Futur, Imaginer Notre Vie de Demain Le thème « Concevoir la Société du Futur, Imaginer Notre Vie de Demain » invite les individus à réfléchir à la vie qu’ils veulent mener et comment il peuvent maximiser leur potentiel. Ce thème vise également à favoriser la co-création de la part de la communauté internationale dans la conception d’une société durable qui soutient les individus dans leurs aspirations quant à la manière dont ils souhaitent vivre leur vie."),
                Image.asset("assets/images/theme.png",
                width: double.infinity,
                height: 200,),
              const  Padding(padding: EdgeInsets.only(top: 8)),
             const Text("La Mascotte", style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromARGB(255, 10, 131, 231)),),
            const Text("La mascotte de l’Expo 2025 Osaka Kansai, appelée Myaku-Myaku, s’inspire du logo de l’Exposition et de l’eau – symbole d’Osaka, la « cité de l’eau ». Myaku–Myaku est polymorphe et fluide  ses cellules rouges peuvent être séparées et son corps peut changer de forme librement selon d’infinies variations."),
      
                Image.asset("assets/images/mascot.png",
                width: double.infinity,
                height: 200,),
      
            ],
            
            ),
            
            
          ),
      
      
      
      
    );
  }
}