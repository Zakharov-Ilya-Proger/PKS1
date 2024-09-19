import 'package:flutter/material.dart';
import 'package:pks3/models/KvasItem.dart';
import 'package:pks3/pages/KvasPage.dart';
import '../components/KvasCard.dart';

final List<KvasItem> data = [
  KvasItem(
      "Классический квас",
    "Классический квас — это традиционный напиток, изготовленный из ржаного или ячменного солода, воды, дрожжей и сахара. Он имеет характерный сладковатый вкус с легкой кислинкой и приятным ароматом. Классический квас часто подают охлажденным и является отличным освежающим напитком в жаркую погоду.",
      "https://i.pinimg.com/564x/ed/ee/c6/edeec6c7a5908d21b225c2ad20978572.jpg",
      ),
  KvasItem(
      "Яблочный квас",
    "Яблочный квас — это уникальный напиток, который сочетает в себе вкус яблок и традиционного кваса. Он изготавливается из яблочного сока, ржаного солода, воды и дрожжей. Яблочный квас имеет сладкий и освежающий вкус с легкой кислинкой, что делает его отличным выбором для тех, кто любит фруктовые напитки.",
      "https://leader-dostavka.kz/upload/iblock/0b5/pt6ysqojy8qe8loch3zcn65mz74t31s1.jpg",
      ),
  KvasItem(
      "Хлебный квас",
    "Хлебный квас — это напиток, изготовленный из ржаного хлеба, воды, дрожжей и сахара. Он имеет насыщенный вкус и аромат, напоминающий свежеиспеченный хлеб. Хлебный квас обладает легкой кислинкой и сладковатым послевкусием. Этот напиток часто подают охлажденным и является отличным освежающим напитком в жаркую погоду.",
      "https://frankfurt.apollo.olxcdn.com/v1/files/zmobjyi4ujj62-KZ/image",
      ),
  KvasItem(
      "Медовый квас",
    "Медовый квас — это сладкий и ароматный напиток, изготовленный из меда, ржаного солода, воды и дрожжей. Он имеет насыщенный вкус меда с легкой кислинкой. Медовый квас часто подают охлажденным и является отличным освежающим напитком, который также обладает полезными свойствами меда.",
      "https://leader-dostavka.kz/upload/iblock/0b5/pt6ysqojy8qe8loch3zcn65mz74t31s1.jpg",
      ),
  KvasItem(
      "Имбирный квас",
      "Имбирный квас — это пряный и освежающий напиток, изготовленный из имбиря, ржаного солода, воды, дрожжей и сахара. Он имеет характерный вкус имбиря с легкой кислинкой и приятным ароматом. Имбирный квас часто подают охлажденным и является отличным выбором для тех, кто любит пряные напитки.Эти описания могут быть использованы для создания карточек квасов в вашем приложении или на веб-сайте.",
      "https://pic.rutubelist.ru/video/ee/54/ee541f51b2ec48069338d524b0aec792.png",)

];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Align(
        alignment: Alignment.center,
        child: Text("Страница всех квасов"),
      ),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: data.length,
            itemBuilder:
            (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) =>
                          kvasPage(item: data[index])
                      )
                    );
                  },
                  child: KvasCard(item: data[index],),
                ),
              );
            }
        ),
      ),
    );
  }
}
