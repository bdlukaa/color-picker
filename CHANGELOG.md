Date format: DD/MM/YYYY

## [01/02/2021] - 1.0.3

- Code formatting and organizing imports
- Dispose `ControllableExpansionTileController` to release resources
- Moved app builder to a different file
- `SharedPreferences` instance is now not on `main`
- Color info:
    - All color infos are part of `color_info.dart`
    - New `ColorName` widget to replace all the others `[ColorName]Name`
- NetworkImageSelector:
    - Now listener is set only once at `initState`
- Lang: 
    - added `colorWithOpacity()`
    - minHeight
- Removed loading animations, since everything is sync
- Added `MinHeight` widget and set min height for screens
- Shrink `AppBar` when screen size <= 500

## [30/01/2021] - 1.0.2

- Deleted splash made in flutter. All native side now
- Title is now generated according to the lang
- Colors in `PaletteHuePicker` does not change opacity anymore
- Zoomed scaffold:
    - Fixed gesture detector size
    - Fixed gesture detector changing size

## [29/01/2021] - 1.0.1

- Code formatting
- Change all possible `StatefulWidget`s to `StatelessWidget`s (shrink code and improve performance)
- Removed dead code and code comments
- Upgrade all the packages
