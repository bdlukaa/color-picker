Date format: DD/MM/YYYY

## [03/02/2021] - 1.0.5

- `SupportedPlatforms` widget
- Keep the state of the content screen in `Zoomed Scaffold` to avoid losing the state in screen resizing
- Fixed InkWell displaying behind the first item in Named Picker
- Dark background instead of White when in dark mode
- Removed borders from Pallete Picker
- Organized all the imports

## [02/02/2021] - 1.0.4

- Improve the README with detailed info
- Add info about the project and the developer in the settings page
- Copy a color to clipboard (rgb, hex and hsl) in css style
- Added a LICENSE
- Added `url_laucher` package
- Lang:
  - added `copyToClipboard` and `copiedToClipboard`
  - added `supportedPlatforms`
  - added `about`, `author`, `openSource` and `madeWithFlutter`

## [01/02/2021] - 1.0.3

- Code formatting and organizing imports
- Dispose `ControllableExpansionTileController` to release resources
- Moved app builder to a different file
- `SharedPreferences` instance is now not on `main`
- Color info:
  - All color infos are `part of` `color_info.dart`
  - New `ColorName` widget to replace all the others `[ColorName]Name`
- NetworkImageSelector:
  - Now listener is set only once at `initState`, improving performance
- Lang:
  - added `colorWithOpacity()`
  - `minHeight`
- Removed loading animations, since everything is sync-ish
- Make drag from the center of the indicator, not the top-left
- Responsive:
  - Added `MinHeight` widget and set min height for different UIs
  - Shrink `AppBar` when screen size <= 500

## [30/01/2021] - 1.0.2

- Deleted splash made in flutter. All native side now
- Title is now generated according to the lang
- Colors in `PaletteHuePicker` does not change opacity anymore
- Zoomed scaffold:
  - Fixed gesture detector size
  - Fixed gesture detector changing size
  - Fixed gesture detector ending (closing and opening when in a specific offset)

## [29/01/2021] - 1.0.1

- Code formatting
- Change all possible `StatefulWidget`s to `StatelessWidget`s (shrink code and improve performance)
- Removed dead code and code comments
- Upgrade all the packages