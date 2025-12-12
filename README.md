# 🤝 ResolutionApp

> **Conectando problemas a soluções através da colaboração comunitária.**

## 📖 Sobre o Projeto

O **ResolutionApp** é uma plataforma mobile desenvolvida para incentivar a colaboração e o apoio mútuo dentro de uma sociedade ou comunidade. O objetivo principal é simples, mas poderoso: criar um espaço onde pessoas possam compartilhar problemas do dia a dia e receber ajuda, conselhos ou soluções de outras pessoas.

### Como funciona?

A dinâmica do aplicativo foca na troca de experiências:

1.  **Postagem de Problemas:** Um usuário relata uma dificuldade.
    - _Exemplo:_ "Estou com um vazamento na encanação da rua e não sei o que fazer."
2.  **Colaboração (Soluções):** A comunidade responde com orientações práticas ou contatos úteis.
    - _Resposta 1:_ "Isso é responsabilidade da companhia de água, você deve abrir um chamado no site deles." 
    - _Resposta 2:_ "Tive um problema parecido, chamei o encanador João (Tel: XX-XXXX), ele resolveu rápido."
3.  **Interação e Validação:** Outros usuários podem interagir com as soluções propostas. Através de **likes e dislikes**, a comunidade avalia as respostas, garantindo que as soluções mais úteis e confiáveis ganhem destaque e ajudem mais pessoas.

---

## 🚀 Tecnologias Utilizadas

Este projeto foi desenvolvido utilizando uma arquitetura moderna, separando o Backend do Frontend para garantir escalabilidade e performance.

### 📱 Mobile (Frontend)

O aplicativo foi construído com **Flutter**, garantindo uma experiência nativa tanto em Android quanto em iOS.

- **Linguagem:** Dart
- **Framework:** Flutter
- **Gerenciamento de Estado:** `Provider` e `Consumer` 

### ⚙️ Backend (API)

A lógica de negócios e persistência de dados reside em uma API robusta desenvolvida por mim mesmo.

- **Linguagem:** Go (Golang)
- **Segurança:** Autenticação via APIKEY e  **JWT (JSON Web Token)** com expiração automática para garantir a segurança das sessões dos usuários.

---

## 📦 Instalação e Execução

Para rodar o projeto localmente, você precisará executar dois ambientes em paralelo: a **API (Backend)** e o **App (Mobile)**.

### Pré-requisitos

- [Flutter SDK](https://flutter.dev/docs/get-started/install) instalado.
- [Go](https://go.dev/doc/install) instalado (para rodar a API localmente, se necessário).
- Emulador Android/iOS ou dispositivo físico.

### Passo 1: Executar a API

O aplicativo depende da API para realizar login, postar problemas e buscar soluções.
👉 **Acesse a documentação e o código da API aqui:** [resolution-api](https://github.com/italomsilva/go-resolution-api)

_Siga as instruções do repositório acima para colocar o servidor Go no ar._

### Passo 2: Executar o Aplicativo

Com a API rodando, siga os passos abaixo:

1.  Clone este repositório:
    ```bash
    git clone https://github.com/italomsilva/resolution_app.git
    ```
2.  Entre na pasta do projeto:
    ```bash
    cd resolution_app
    ```
3.  Instale as dependências do Flutter:
    ```bash
    flutter pub get
    ```
4.  Crie um arquivo `.env` na raiz do projeto com as credenciais de acordo como configurou sua api:
    ```bash
    BASE_BACKEND_URL = (http://sua.url)
    API_KEY_VALUE = (sua apikey)
    ```
5.  Execute o aplicativo:
    ```bash
    flutter run
    ```
---

## ⬇️ Download / Acesso Rápido

Caso queira apenas testar o aplicativo sem rodar o código fonte, você pode baixar a versão mais recente aqui: (funciona apenas com a api no padrão)

🔗 **[Link do App](https://github.com/italomsilva/resolution_app/release)**

---

## 🤝 Contribuição

Contribuições são sempre bem-vindas! Sinta-se à vontade para abrir uma _issue_ para relatar bugs ou enviar um _pull request_ com melhorias.

---

Feito com 💙 por [Italo](https://devitalo-about.vercel.app/).
