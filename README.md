# Newsera

![alt text](./media/home_screen.png?raw=true)

A Flutter App Project which uses NewsApi.org as of api resource.

# Steps to download and run the project

1) Run `git clone https://github.com/flutter-ark/newsera.git && cd ./newsera`.
2) Run the command `clear && flutter clean && flutter run`. 
3) If any error occoured then run `flutter doctor -v` from root folder of the project.


# Build

![alt text](./media/splash_screen.png?raw=true)

1) Run the command from Root folder of the project `flutter build <apk|ios> --<debug|profile|release>`.
e.g. `flutter build ios --release`.

___
[<img src="./media/PlayStoreButton.gif">](./build/release/newsera.apk)
___

___
[<img src="./media/appleStoreButton.png">](./build/release/newsera.ipa)
___

###NOTE: Check `build > release` folder for a prebuild `newsera.ipa` or `newsera.apk` file for testing purpose only if above link is not working.
# Current features
1) `Network Change Detection`.
2) `Search`.
3) `Lazy Load`.
4) `Bookmark`.
5) `Provider` based `reactivity`.

# Future Enhancements on mind
1) `DarkMode theme`.
2) `Proper Theme` for `light mode` and `dark mode`

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
