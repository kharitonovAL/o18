# Repository
This readme presented in Russian 🇷🇺 and [English](#en)🇺🇸 version.

# Оператор 18 (RU 🇷🇺)
## От автора
Оператор18 — это система автоматизации процессов управляющих компаний, призванная упростить их работу, повысить контроль исполнения заявок и т.д.

Я Алексей, основатель и автор этого проекта. Я занимаюсь фронтом. Вместе со мной над проектом работает еще один сооснователь, он занимается бэком.

Нам хотелось сделать адекватное решение, качественное, простое в обслуживании и развертывании, интуитивно понятное, быстрое. Кроме того, лично мне, как разработчику, хотелось написать хорошую систему не монолитом, а проект, код которого было бы легко поддерживать и, при необходимости, менять модульно. В чем-то нам удалось добиться этого. Но до конца реализовать проект не хватает времени. 

Поэтому, мы приняли решение отдать проект в массы. Может быть, кто-то сможет реализовать его или сделать лучше.

В этом репозитории последняя рабочая версия проекта. Приложения из сторов пока убраны. Пользоваться репозиторием может кто угодно и как угодно. Стоит отметить, что данный репозиторий больше предназначен для разработчиков, потому что, по крайней мере пока, его нельзя взять и запустить "из коробки".

Если хочется посмотреть рабочую веб-версию кабинета оператора - переходите по [ссылке](https://v2.operator18.ru/#/). Логин: operator@mail.ru, пароль: operator.

Нашу версию мы оставим рабочей, поэтому в репозитории вы не найдете ключей API и прочей информации.

Весь UI отрисован в фигме и доступен по [ссылке](https://www.figma.com/community/file/1281838751988417386/%D0%9E%D0%BF%D0%B5%D1%80%D0%B0%D1%82%D0%BE%D1%8018-Public). Нужно сказать, что некоторые UI элементы были переписаны (убраны) в ходе разработки, некоторых экранов в мобильной версии не стали делать (по разным причинам). По ссылке выложена последняя версия UI которая была мной использована. Версия UI для приложения жителей не была заказана для отрисовки в целях экономии бюджета. Я планировал просто сделать её по образу и подобию общей темы. В целом, все UI элементы есть, и дописать приложение для жителей не составит труда.

## Контакты
Если вам интересно поучаствовать в проекте, или внедрить его, или поддержать проект, то можете связаться с нами через:
- [Telegram](https://t.me/kharitonov_al)
- [Email](mailto:ceo@operator18.ru)

# О проекте
## Стэк
Стэк технологий, использованных при разработке следующий:
- фронт написан на Flutter, при этом часть проектов написана с использованием архитектуры BloC, а часть с использованием MobX;
- бэк поднят на VPS, на котором развернут Parse Server на CentOS;
- бот написан на Dart и только для Телеграмма, запускается на VPS через Docker;
- для пуш-уведомлений используется Google Firebase - Cloud Messaging, поэтому, если будете работать над своей версией Оператора18, не забудьте добавить конфиг файл от Firebase, так же инициализировать Fierbase в проекте;
- регистриация пользователей на Parse Server;

## Репозиторий
В репозитории вы найдете 4 папки:
- o18_client - мобильное приложение для жителей;
- o18_staff - мобильное приложение для сотрудников УК;
- o18_web - веб-приложение для оператора;
- bot_app - телеграмм бот для жителей;
- CONF и parse_server - конфигурационные файлы для Parse Server.

Приложение для жителей не переписано на вторую версию (старый UI) не хватает времени.

## Роли в системе
В самой системе предусмотрена ролевая модель доступа. Существуют следующие роли:
- оператор;
- клиент (он же собственник, он же житель);
- сотрудник УК.

## Функционал "Оператора 18"
Функционал Оператора18 следующий.

- **Веб кабинет оператора**
    - Модуль заявки
        >_В модуле Заявки оператор может создавать/редактировать заявки, назначать исполнителей, отправлять пуш-уведомления заявителям, печатать наряд-задания, печатать разные журналы по заявкам._

    - Модуль Дома
        >_Модуль Домов позволяет вести базу домов, карточку дома, перечень квартир, лицевых счетов, собственников, а также отправлять сообщения всем собственникам какого-то конкретного дома._

    - Модуль Счетчики
        >_Модуль Счетчиков позволяет просматривать показания, которые передали собственники через мобильные приложения._

    - Модуль Контрагенты
        >_Модуль контрагентов дает возможность вести базу контрагентов и их сотрудников, а также регистрировать сотрудников для доступа к системе._

- **Мобильные приложения для Сотрудников**
    >_Приложение позволяет просматривать заявки для конкретного исполнителя или мастера, закрывать или переносить заявки, получать сообщения о новых заявках или от руководства._

- **Мобильные приложения для Клиентов**
    >_В приложении можно получать сообщения от УК, создавать заявки и отслеживать статус выполнения, подавать показания счетчиков и отслеживать баланс лицевого счета в профиле._

- **Telegram бот для Клиентов**
    >_С помощью бота можно подавать заявки в управляющую компанию, а также подавать показания счетчиков._

## Инструкция по запуску
### Запуск веб версии (репозиторий o18_web) на своем VPS
1. Сначала необходимо подготовить `.env` файл, который нужно положить в папку `/assets`. Это файл должен сожержать следующие ключи:
```bash
  // Идентификатор приложения в Parse Server
  PARSE_APP_ID=your_app_id_from_parse_server

  // Клиентский ключ приложения в Parse Server
  CLIENT_KEY=your_client_key_from_parse_server

  // REST API ключ приложения в Parse Server
  REST_API_KEY=your_rest_api_key_from_parse_server

  // URL сервера Parse
  PARSE_SERVER_URL=https://<your_parse_server_url>/parse/

  // Секретный ключ FCM
  FCM_SERVER_KEY=your_fcm_server_key
  FCM_URL=https://fcm.googleapis.com/fcm/send
```

2. Далее запускаем сборку web-приложения Оператор18. Для этого перейдите в терминале в папку o18_web и выполните следующие команды:
```bash
flutter clean
flutter pub get
flutter build web -t lib/main_development.dart
```

3. После выолнения генерации файлов, скопируйте шрифты из `assets/fonts` в `build/web/assets/fonts`, это необходимо для корректного отображения шрифтов при печати различных журналов по заявкам.

4. Скопируйте файл `.env` из `/assets` в `build/web/assets`, иначе приложение не запустится из-за отсутствия секретных ключей.

5. Разверните новую сборку на сервере (я использовал утилиту [rsync](https://linux.die.net/man/1/rsync)), выполнив следующую команду из терминала. Введите пароль пользователя `root`, когда он будет запрошен.
```bash
rsync -rvzhe ssh build/web/* root@<your_parse_server_ip_address>:/var/www/operator18.ru

// конечный путь на вашем сервере может отличаться от указанного тут - /var/www/operator18.ru
```

### Запуск мобильных приложений
Мобильные приложения можно смело запускать/собирать по [официальному гайду от Flutter](https://flutter.dev/docs/deployment).

Нужно так же поменять идентификатор приложения для платформ:
- iOS 
    - запустить Xcode и присвоить проекту свою команду, а так же уникальный bundleId;

- Android
    - вписать свой applicationId в слудующие места:
        - android/app/build.gradle
        - android/app/src/main/AndroidManifest.xml
---
# Operator 18 (EN 🇺🇸)<a id='en'></a>
## From the Author
Operator 18 is an automation system for property management companies designed to simplify their work, enhance control over order execution, and more.

I'm Alexey, the founder and author of this project. I handle the frontend. I'm working on the project alongside another co-founder who manages the backend.

We aimed to create a solution that is adequate, high-quality, easy to maintain and deploy, intuitively understandable, and fast. As a developer, I wanted to build a system that is not a monolith but one where the code can be easily maintained and modularly changed if necessary. We partially achieved this goal, but we lack the time to fully implement the project.

Therefore, we have decided to release the project to the public. Perhaps someone can implement it or improve upon it.

In this repository, you'll find the latest working version of the project. The applications from app stores have been removed for now. Anyone can use and interact with the repository. It's worth noting that this repository is more intended for developers because, at least for now, it can't be easily set up and run "out of the box."

If you want to see the working web version of the operator's dashboard, follow this [link](https://v2.operator18.ru/#/). Login: operator@mail.ru, password: operator.

We will keep our version working, so you won't find API keys and other sensitive information in this repository.

The entire UI is designed in Figma and is available via this [link](https://www.figma.com/community/file/1281838751988417386/%D0%9E%D0%BF%D0%B5%D1%80%D0%B0%D1%82%D0%BE%D1%8018-Public). It's important to note that some UI elements were rewritten (removed) during development, and some screens in the mobile version were not created for various reasons. The link contains the latest version of the UI that I used. The UI version for the resident application was not ordered for drawing to save on the budget. I planned to create it in the same theme. In general, all UI elements are available, and completing the resident application should not be a problem.

## Contacts
If you are interested in participating in the project, implementing it, or supporting it, you can contact us through:
- [Telegram](https://t.me/kharitonov_al)
- [Email](mailto:ceo@operator18.ru)

# About the Project
## Tech Stack
The technology stack used in the development includes:
- Frontend is built with Flutter, with some projects using the BloC architecture, and others using MobX.
- Backend is hosted on a VPS, running Parse Server on CentOS.
- The bot is written in Dart and is only for Telegram, running on a VPS through Docker.
- Google Firebase - Cloud Messaging is used for push notifications. So, if you work on your own version of Operator18, don't forget to add the Firebase config file and initialize Firebase in the project.
- User registration is handled by Parse Server.

## Repository
In the repository, you will find four folders:
- o18_client - mobile application for residents.
- o18_staff - mobile application for property management company staff.
- o18_web - web application for the operator.
- bot_app - Telegram bot for residents.
- CONF and parse_server - configuration files for Parse Server.

The application for residents has not been updated to the second version (old UI) due to time constraints.

## Roles in the System
The system itself includes a role-based access model with the following roles:
- Operator.
- Client (also known as an owner or resident).
- Property management company staff.

## Operator 18 Features
Operator 18 has the following functionality.

- **Operator Web Dashboard**
    - Requests Module
        >_In the Requests module, the operator can create/edit requests, assign tasks to performers, send push notifications to applicants, print work orders, and print various journals related to requests._

    - Houses Module
        >_The Houses module allows managing the database of houses, house profiles, lists of apartments, personal accounts, owners, and sending messages to all owners of a specific house._

    - Meters Module
        >_The Meters module enables viewing readings submitted by owners through mobile applications._

    - Counterparties Module
        >_The Counterparties module provides the ability to manage a database of counterparties and their employees, as well as register employees for access to the system._

- **Mobile Applications for Staff**
    >_The application allows viewing requests for a specific performer or technician, closing or rescheduling requests, and receiving notifications about new requests or messages from management._

- **Mobile Applications for Clients**
    >_In the application, clients can receive messages from the property management company, create requests, track the status of execution, submit meter readings, and monitor the balance of their personal account in their profile._

- **Telegram Bot for Clients**
    >_With the bot, clients can submit requests to the property management company and submit meter readings._

## Installation Instructions
### Running the Web Version (o18_web repository) on Your VPS
1. First, prepare an `.env` file that should be placed in the `/assets` folder. This file should contain the following keys:
```bash
  // Parse Server Application ID
  PARSE_APP_ID=your_app_id_from_parse_server

  // Parse Server Client Key
  CLIENT_KEY=your_client_key_from_parse_server

  // Parse Server REST API Key
  REST_API_KEY=your_rest_api_key_from_parse_server

  // Parse Server URL
  PARSE_SERVER_URL=https://<your_parse_server_url>/parse/

  // Firebase Cloud Messaging Secret Key
  FCM_SERVER_KEY=your_fcm_server_key
  FCM_URL=https://fcm.googleapis.com/fcm/send
```

2. Next, build the Operator 18 web application. To do this, open your terminal, navigate to the o18_web folder, and run the following commands:
```bash
flutter clean
flutter pub get
flutter build web -t lib/main_development.dart
```

3. After generating the files, copy the fonts from `assets/fonts` to `build/web/assets/fonts` to ensure proper font rendering for printing various journals related to requests.

4. Copy the `.env` file from `/assets` to `build/web/assets`. Otherwise, the application won't start due to missing secret keys.

5. Deploy the new build to your server (I used the [rsync utility](https://linux.die.net/man/1/rsync)) by running the following command in your terminal. Enter the `root` user's password when prompted.
```bash
rsync -rvzhe ssh build/web/* root@<your_parse_server_ip_address>:/var/www/operator18.ru

// The final path on your server may differ from the one specified here - /var/www/operator18.ru
```

### Running the Mobile Applications
You can confidently run/build the mobile applications following the official [Flutter deployment guide](https://flutter.dev/docs/deployment).

You should also change the application identifier for the platforms:
- iOS
    - Open Xcode and assign your team to the project, and use a unique bundleId.

- Android
    - Update your applicationId in the following places:
        - android/app/build.gradle
        - android/app/src
