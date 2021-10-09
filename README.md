# COLORIME

A colorful clock that updates the sphere color every second to show you the date and time in a beautiful way.

**Table of contents:**

- [COLORIME](#colorime)
  - [Project description](#project-description)
  - [Objectives to achieve](#objectives-to-achieve)
  - [Things I've learned](#things-ive-learned)
  - [Build the project](#build-the-project)
  - [Third party software](#third-party-software)
  - [Attributions](#attributions)
    - [Fonts](#fonts)
  - [Acknowledgements](#acknowledgements)
  - [License & Copyright](#license--copyright)

## Project description

Colorime is a personal project based on several websites that shows the time and a background colour changing along the day. The color change is based on the ability to form a different hexadecimal color code with the 86400 seconds of the day. When I saw that, I thought that I want to do it myself for an iOS device. So, I've built this app. I've also added some configuration options to give the user more personalisation. The user is able to choose if the date is shown or not (creating a beautiful gradient that goes from date to time) or what kind of colour intensity want to see ('normal', 'bright' or 'vivid').

## Objectives to achieve

When I started this project I set some objectives to achieve in order to learn new things. I've been able to achieve almost all of them.

- [x] Use MVP architecture pattern.
- [x] Do not add third party libraries.
- [x] Add multi-language & internalization support.
- [x] Support iPhone & iPad.
- [x] Show plain background color or gradient background color depending on the shown information.
- [x] Let the user configure how the app should work.
- [ ] Create an iOS 14 widget.

### Notes: <!-- omit in toc -->

- Widget idea has been abandoned because of how widget's refresh works. The OS doesn't give the chance to update the widget every second, which is it necessary for a clock. Quoting [Apple Developer documentation](https://developer.apple.com/documentation/widgetkit/keeping-a-widget-up-to-date):

> WidgetKit renders the views on your behalf in a separate process. As a result, your widget extension is not continually active, even if the widget is onscreen... Reloading widgets consumes system resources and causes battery drain due to additional networking and processing. To reduce this performance impact and maintain all-day battery life, limit the frequency and number of updates you request to what’s necessary... For a widget the user frequently views, a daily budget typically includes from 40 to 70 refreshes. This rate roughly translates to widget reloads every 15 to 60 minutes, but it’s common for these intervals to vary due to the many factors involved.

## Things I've learned

While building the project I've learned things that I didn't expect:

- Closures can be stored in arrays, iterated & execute them all.
- Completely understand how scroll views works.
- StackViews doesn't use its UI space if you change hidden attribute, but if you change alpha attribute to zero, the stack view will maintain it's UI space but won't be visible.
- Color Sets are colors as an asset.
- The animation of all sublayers added to a view aren't controlled by the view, instead, these animations are handled by the layer itself (implicit-animation).
- To correctly use typealias & static closures.

## Build the project

1. Clone the repository: `git clone https://github.com/raaowx/colorime.git && cd colorime`
2. Open the project: `open colorime.xcodeproj`
3. Configure project with your Apple Developer Account
   1. Go to `colorime > Signing & Capabilities`
   2. Select your `Team`
   3. Set your `Bundle Identifier`
4. Build the project `Product > Build` or use the shortcut `⌘B`

## Third party software

For building and compiling this project you will next the following related software:

- [Xcode](https://developer.apple.com/xcode/)
- [SwiftLint](https://github.com/realm/SwiftLint)

## Attributions

### Fonts

The font used in the project is [Orbitron](https://fonts.adobe.com/fonts/orbitron). Created by [Matt McInerney](https://fonts.adobe.com/designers/matt-mcinerney) and provided by [Adobe Fonts](https://fonts.adobe.com).

## Acknowledgements

- To my friends that help me to choose the font by completing a survey.
- To the website [Hacking with Swift](https://www.hackingwithswift.com) that give me the base for my custom [UIColor](https://www.hackingwithswift.com/example-code/uicolor/how-to-convert-a-hex-color-to-a-uicolor) initializer.

## License & Copyright

The application is licensed under [Mozilla Public License 2.0](LICENSE.txt).

The [app icon](colorime/Assets.xcassets/AppIcon.appiconset/colorime-logo-1024-1x.png) has all rights reserved to the copyright holder.

Copyright © 2021 **Álvaro López de Diego {raaowx}** raaowx@protonmail.com
