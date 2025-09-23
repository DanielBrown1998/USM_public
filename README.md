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

## Screenshots

| | | |
|:-------------------------:|:-------------------------:|:-------------------------:|
| <img src="screenshots/usm1.png" width="250"> | <img src="screenshots/usm2.png" width="250"> | <img src="screenshots/usm3.png" width="250"> |
| <img src="screenshots/usm4.png" width="250"> | <img src="screenshots/usm5.png" width="250"> | <img src="screenshots/usm6.png" width="250"> |
| <img src="screenshots/usm7.png" width="250"> | <img src="screenshots/usm8.png" width="250"> | <img src="screenshots/usm9.png" width="250"> |
| <img src="screenshots/usm10.png" width="250"> | <img src="screenshots/usm11.png" width="250"> | <img src="screenshots/usm12.png" width="250"> |
| <img src="screenshots/usm13.png" width="250"> | <img src="screenshots/usm14.png" width="250"> | <img src="screenshots/usm15.png" width="250"> |
| <img src="screenshots/usm16.png" width="250"> | <img src="screenshots/usm17.png" width="250"> | <img src="screenshots/usm18.png" width="250"> |



## Diagramas

### Diagrama de Casos de Uso

![Diagrama de Casos de Uso](docs/use_case_diagram.png)

### Diagrama de Componentes

![Diagrama de Componentes](docs/component_diagram.png)

### Diagrama de Classes

![Diagrama de Classes](docs/class_diagram.png)

### Diagramas de Sequência

**Login**

![Diagrama de Sequência - Login](docs/login_sequence_diagram.png)

**Register**

![Diagrama de Sequência - Register](docs/register_sequence_diagram.png)

**Recover Password**

![Diagrama de Sequência - Recover Password](docs/recover_password_sequence_diagram.png)

**Add Monitoria**

![Diagrama de Sequência - Add Monitoria](docs/add_monitoria_sequence_diagram.png)

### Diagramas de Atividade

**Login**

![Diagrama de Atividade - Login](docs/login_activity_diagram.png)

**Register**

![Diagrama de Atividade - Register](docs/register_activity_diagram.png)

**Recover Password**

![Diagrama de Atividade - Recover Password](docs/recover_password_activity_diagram.png)

**Add Monitoria**

![Diagrama de Atividade - Add Monitoria](docs/add_monitoria_activity_diagram.png)

**List Monitorias**

![Diagrama de Atividade - List Monitorias](docs/list_monitorias_activity_diagram.png)