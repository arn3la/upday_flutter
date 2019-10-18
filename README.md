# Shutterstock - private app

[![N|Solid](https://assets.themuse.com/uploaded/companies/1147/small_logo.png?v=9cfbf5459e8298ad3844d0a9db881747780e9ab472040ebde47fe885560dba32)](https://developers.shutterstock.com/)

**Shutterstock - private app** is the mobile application that fetches pictures from the Shutterstock API and displays them in an infinite scrollable view.
The app is created in the Flutter framework, so there is a version for Android and iOS.

## Technical details
1.  [Flutter](https://flutter.dev/)
   The app is created in the Flutter framework backed by Google for cross-mobile development.
Flutter is using [Dart](https://dart.dev/) which is object-oriented, class defined, garbage-collected programming language.

2. [Provider](https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple)
There are a few options for state management in Flutter. This application is pretty straight forward (fetching the list of images from API and show to user), so the decision was Provider.
Provider allows us to have state management and good separation of business logic and UI elements without much boilerplate code.
It's easy to use, to understand, and in the future, we have good basic to implement new features.
    - Libraries - provider: ^3.1.0


3. [Flutter_18n](https://flutter.dev/docs/development/accessibility-and-localization/internationalization)
This library is used for internationalization which means making the application available in another language, country or locale.
In the first version, only the English language is supported.
    - Libraries - intl: ^0.15.7 &  flutter_i18n: ^0.6.3

## Code style
I have used [ANALYSIS OPTION](https://dart.dev/guides/language/analysis-options) as linter which is recommended by Flutter and Dart team.
The Flutter team has a list of curated Dart lints and it's customizable.

## API Reference
The application is using [Shutterstock API](https://api-explorer.shutterstock.com/) for fetching the list of images.
The API **'v2/images/search'** which is used in this app, can have parameters "per_page" and "page" if clients want to create smooth infinite scrolling with pagination. If these parameters are not defined, API returns 20 items by default.

## Tests
This application is covered with 3 types of tests:
- unit
- widget
- integration

Libraries - mockito, transparent_image, flutter_test, test,  flutter_driver

- To run unit and widget test, use this command:
```sh
$ flutter test
```
- To run integration test, use this command:
```sh
$ flutter driver -t test_driver/main.dart
```

## Attention
* The application is not tested on the iOS device and tablets.
* Error messages are not specific, can be confusing to the user.
*  The problem with loading images, need to be fixed in the next release.
(Description of problem: After the successful downloading list of images, the process of getting images from the URL of the image is started. If in the moment of downloading image some error happens, the image will not be showed anymore in the list, only placeholder will be visible to the user.)
Example with an internet connection:
   1. Turn on wifi
   2. Open the app(you will see images)
   3. Turn off wifi
   4. Scroll(you will see only placeholder)
   5. Turn on wifi and scroll in both direction and there you will see that even if you have internet connection now and new items are downloaded, only placeholder is visible for old items.

## Links
For my CV and links to my public profile please contact me via mail: arnela.jasarevic1996@gmail.com
