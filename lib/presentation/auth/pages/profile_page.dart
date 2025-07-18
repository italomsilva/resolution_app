import 'package:flutter/material.dart';
import 'package:resolution_app/app_theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: brightness == Brightness.light
            ? AppTheme.whiteColor
            : AppTheme.blackColor,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.edit_outlined)),
        title: Text("Meu Perfil"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.logout))],
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text("Italo Monteiro Silva"),
                            Text("jdbjbdjb@gmail.com"),
                          ],
                        ),
                        IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                      ],
                    ),
                    Divider(color: const Color.fromARGB(55, 134, 134, 134)),
                    Row(
                      children: [
                        Icon(Icons.person),
                        Text("aloit085"),
                        Spacer(),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text("Ver mais"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            // Permite que as abas ocupem o restante do espaço vertical
            child: DefaultTabController(
              initialIndex: 0,
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    tabs: const [
                      Tab(
                        icon: Icon(Icons.report_problem_outlined),
                        text: "Problemas",
                      ), // Adicionei texto
                      Tab(
                        icon: Icon(Icons.lightbulb),
                        text: "Soluções",
                      ), // Adicionei texto
                    ],
                  ),
                  Expanded(
                    // Permite que o TabBarView preencha o espaço restante da TabController Column
                    child: TabBarView(
                      children: [
                        Center(
                          child: Text("Conteúdo dos Meus Problemas aqui"),
                        ),
                        Center(
                          child: Text("Conteúdo das Minhas Soluções aqui"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
