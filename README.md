# Flutter - Realtime Exchange

Este projeto é um aplicativo desenvolvido em **Flutter**, que exibe cotações de moedas em **tempo real** utilizando a **AwesomeAPI**. O app oferece uma interface simples e intuitiva para converter valores entre **Real (BRL)**, **Dólar (USD)** e **Euro (EUR)** de forma simultânea.

## ✨ Funcionalidades

### 🔁 Conversão em Tempo Real e Simultânea

- 🧮 **Preencha qualquer campo de moeda (BRL, USD ou EUR)** e os outros dois serão atualizados automaticamente com os valores convertidos, conforme a cotação do momento.

### 💡 Interface Responsiva e Intuitiva

- **📱 Design limpo**: Foco na experiência do usuário, com campos fáceis de preencher e resultados rápidos.  
- **🌐 Compatibilidade**: Funciona perfeitamente em dispositivos Android e iOS.

## 📁 Estrutura do Projeto

- `lib/main.dart`: Inicializa o aplicativo Flutter.  
- `lib/app/pages/home.dart`: Tela principal com os inputs e conversões.  
- `lib/app/services/api_service.dart`: Responsável por buscar as cotações via HTTP.  
- `assets/`: Pasta para imagens, `.env.example` e recursos adicionais.  
- `pubspec.yaml`: Configuração de dependências e ativos.

## 🚀 Como Rodar o Projeto

### 1. Pré-requisitos

Certifique-se de que o **Flutter SDK** está instalado corretamente:

```bash
flutter doctor
```

### 2. Clonar o Repositório

```bash
git clone https://github.com/seu-usuario/flutter-realtime-exchange.git
cd flutter-realtime-exchange
```

### 3. Instalar as Dependências

```bash
flutter pub get
```

### 4. Configurar o Arquivo `.env`

Crie um arquivo `.env` dentro da pasta assets do projeto com o seguinte conteúdo (baseado no exemplo em `assets/.env.example`):

```
API_URL=https://economia.awesomeapi.com.br/json/last/USD-BRL,EUR-BRL
```

✅ **Importante**: Certifique-se de que o `.env` está listado no `.gitignore` para não ser enviado ao GitHub.

### 5. Executar o App

Conecte um dispositivo físico ou abra um emulador:

```bash
flutter run
```

## 🌐 API Utilizada

Este projeto utiliza a [**AwesomeAPI**](https://docs.awesomeapi.com.br/api-de-moedas), que oferece cotações atualizadas em tempo real:

```
https://economia.awesomeapi.com.br/json/last/USD-BRL,EUR-BRL
```

Os dados retornados incluem: valor de compra e venda, variação e timestamp da última atualização.

## 🛠️ Tecnologias

- **Flutter** – Framework para desenvolvimento mobile cross-platform.  
- **Dart** – Linguagem principal utilizada no Flutter.  
- **HTTP** – Para chamadas RESTful à API.  
- **flutter_dotenv** – Gerenciamento de variáveis de ambiente.  
- **AwesomeAPI** – API pública de cotações de moedas.

## 👨‍💻 Autor

Este projeto foi desenvolvido por **Lucas Santos Silva**, Desenvolvedor Full Stack, graduado pela **Escola Técnica do Estado de São Paulo (ETEC)** nos cursos de **Informática (Suporte)** e **Informática para Internet**.

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/bylucasss/)

## 📄 Licença

Distribuído sob a Licença [MIT](./LICENSE).