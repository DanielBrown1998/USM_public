# MON. UERJ-ZO
[![Codemagic build status](https://api.codemagic.io/apps/685edcfa3096b3b0a849063b/685ef8926725832714ff2373/status_badge.svg)](https://codemagic.io/app/685edcfa3096b3b0a849063b/685ef8926725832714ff2373/latest_build)

## Descrição

MON. UERJ-ZO é um aplicativo Flutter desenvolvido para gerenciar e agendar monitorias para a UERJ-ZO. Ele permite que alunos e monitores interajam, marquem sessões de monitoria e acompanhem seus agendamentos. O backend é suportado pelo Firebase Firestore.

## Funcionalidades

*   Autenticação de usuários (alunos/monitores).
*   Visualização de monitorias disponíveis.
*   Agendamento de novas monitorias.
*   Visualização de monitorias agendadas.
*   Gerenciamento de status de monitorias (e.g., MARCADA, PRESENTE, AUSENTE).
*   Busca de alunos.
*   Interface de configuração (a ser detalhada).

## Telas Principais

*   **Login:** Tela inicial para autenticação do usuário.
*   **Home:** Dashboard principal após o login, exibindo:
    *   Cabeçalho com informações do usuário.
    *   Lista de ações rápidas (Buscar Alunos, Matrículas, Monitorias, Config).
    *   Visualização das próximas monitorias.
*   **Adicionar Monitoria:** Modal para agendar uma nova monitoria, selecionando aluno e data.
*   **Lista de Monitorias:** Tela para visualizar todas as monitorias (filtrável por status, data, etc. - a ser detalhado).
*   **Busca de Alunos:** Tela para pesquisar alunos no sistema.

## Tecnologias Utilizadas

*   **Flutter:** Framework de UI para desenvolvimento de aplicativos móveis multiplataforma.
*   **Dart:** Linguagem de programação utilizada pelo Flutter.
*   **Firebase Firestore:** Banco de dados NoSQL em nuvem para armazenamento de dados.
*   **Provider:** Para gerenciamento de estado.
*   **Integration Tests:** Para garantir a qualidade e o fluxo correto das telas.

## Começando

Estas instruções permitirão que você obtenha uma cópia do projeto em execução em sua máquina local para fins de desenvolvimento e teste.

### Pré-requisitos

*   [Flutter SDK](https://flutter.dev/docs/get-started/install)
*   Um editor de código como [VS Code](https://code.visualstudio.com/) ou [Android Studio](https://developer.android.com/studio).
*   Conta no [Firebase](https://firebase.google.com/) e um projeto Firebase configurado.

### Instalação

1.  Clone o repositório:
    ```bash
    git clone https://github.com/DanielBrown1998/USM_Flutter.git
    ```
2.  Navegue até o diretório do projeto:
    ```bash
    cd ./app 
    ```
3.  Instale as dependências:
    ```bash
    flutter pub get
    ```
4.  Configure o Firebase:
    *   Siga as instruções do Firebase para adicionar o Flutter ao seu projeto Firebase ([Android](https://firebase.google.com/docs/flutter/setup?platform=android) e [iOS](https://firebase.google.com/docs/flutter/setup?platform=ios)).
    *   Certifique-se de que o arquivo `google-services.json` (para Android) e `GoogleService-Info.plist` (para iOS) estejam nos locais corretos dentro do seu projeto Flutter.
    *   Configure as regras de segurança do Firestore conforme necessário para sua aplicação.

## Estrutura do Projeto

app/
├── android
├── ios
├── lib/
│   ├── components/  # Widgets reutilizáveis (Header, Drawer, Cards, etc.)
│   ├── models/      # Modelos de dados e objetos de estado (User, Monitoria, Matricula, etc.)
│   ├── screen/      # Widgets de tela (Login, Home, SearchStudent, etc.)
│   ├── services/    # Lógica de negócios e comunicação com backend (FirebaseService, MonitoriasService, etc.)
│   ├── theme/       # Definições de tema do aplicativo
│   └── main.dart    # Ponto de entrada principal do aplicativo
├── test/            # Testes unitários e de widgets
└── integration_test/ # Testes de integração
    └── app_test.dart # Teste de fluxo principal do aplicativo



## Executando o Aplicativo

Para executar o aplicativo em um emulador ou dispositivo conectado:

```
bash: flutter run
```
## realizando o teste de integracao

```
bash: flutter test integration_test/app_test.dart
```

## Imagens do app

<table>
  <tr>
    <td align="center">
      <img src="app/lib/assets/readme_images/login.png" alt="Tela de Login" height="300">
      <br><sub>Tela de Login</sub>
    </td>
    <td align="center">
      <img src="app/lib/assets/readme_images/home.png" alt="Tela Home" height="300">
      <br><sub>Tela Home</sub>
    </td>
    <td align="center">
      <img src="app/lib/assets/readme_images/add_monitoria.png" alt="Modal Adicionar Monitoria" height="300">
      <br><sub>Modal Adicionar Monitoria</sub>
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="app/lib/assets/readme_images/search_students.png" alt="Tela de Busca de Alunos" height="300">
      <br><sub>Busca de Alunos</sub>
    </td>
    <td align="center">
      <img src="app/lib/assets/readme_images/list_all_monitorias.png" alt="Tela de Lista de Monitorias" height="300">
      <br><sub>Lista de Monitorias</sub>
    </td>
     <!-- Adicione mais <td> aqui se tiver mais imagens para esta linha -->
  </tr>
</table>




