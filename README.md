<div>
  <h1 align="center">Color Picker</h1>
  <p align="center" >
    <a title="Github License">
      <img src="https://img.shields.io/github/license/bdlukaa/color-picker" />
    </a>
    <a title="PRs are welcome">
      <img src="https://img.shields.io/badge/PRs-welcome-brightgreen.svg" />
    </a>
  <div>
  <p align="center">
    <a title="Buy me a coffee" href="https://www.buymeacoffee.com/bdlukaa">
      <img src="https://img.buymeacoffee.com/button-api/?text=Buy me a coffee&emoji=&slug=bdlukaa&button_colour=FF5F5F&font_colour=ffffff&font_family=Lato&outline_colour=000000&coffee_colour=FFDD00">
    </a>
  </p>

An app made in Flutter to help people choose the colors they will use in their projects!

</div>

## Features

Pick a color from a picker wheel, palette, value, named and even from an image.\
Liked a color? Favorite it to use it later or copy it to clipboard.\
Is it too bright? Don't worry, use the dark theme.\

✔️ Resposive - The zoomed scaffold will expand in screens larger than 950px\
✔️ [Accessible](https://flutter.dev/docs/development/accessibility-and-localization/accessibility) - Includes tooltips and `Semantics` to accessibility\
✔️ [Internacionalizated](https://flutter.dev/docs/development/accessibility-and-localization/internationalization) - Includes support for English and Portuguese

### Color info

You can see a color information or parse with the following color spaces:

| Space             | See info | Parse | Copy |
| :---------------- | :------: | :---: | :--: |
| RGB               |    ✔️    |  ✔️   |  ✔️  |
| HEX               |    ✔️    |  ✔️   |  ✔️  |
| HSL               |    ✔️    |  ✔️   |  ✔️  |
| HSV               |    ✔️    |  ✔️   |      |
| Cielab            |    ✔️    |  ✔️   |      |
| XYZ               |    ✔️    |       |      |
| Color Temperature |    ✔️    |       |      |

### Color Temperature

The color temperature value is based on RGB. It can be not totally accurate if you use other color schemes that convertion is not 100% to RGB. The math is based on [this wikipedia article](https://en.wikipedia.org/wiki/Color_temperature)

## Screenshots

<!-- Use html in here because markdown does not support width and height -->
<table>
  <tr>
    <td>Wheel picker</td>
    <td>Palette picker</td>
  </tr>
  <tr>
    <td><img src="screenshots/wheel_picker.png" width=300 height=480></td>
    <td><img src="screenshots/palette_picker.png" width=300 height=480></td>
  </tr>
</table>
<table>
  <tr>
    <td>Value picker</td>
    <td>Named picker</td>
  </tr>
  <tr>
    <td><img src="screenshots/value_picker.png" width=300 height=480></td>
    <td><img src="screenshots/named_picker.png" width=300 height=480></td>
  </tr>
</table>
<table>
  <tr>
    <td>Image picker</td>
    <td>Favorite colors</td>
  </tr>
  <tr>
    <td><img src="screenshots/image_picker.png" width=300 height=480></td>
    <td><img src="screenshots/favorite_colors.png" width=300 height=480></td>
  </tr>
</table>
<table>
  <tr>
    <td>Settings</td>
  </tr>
  <tr>
    <td><img src="screenshots/settings.png" width=300 height=480></td>
  </tr>
</table>

# Contribution

Feel free to [open an issue](https://github.com/bdlukaa/color-picker/issues/new) if you find an error or [make pull requests](https://github.com/bdlukaa/color-picker/pulls).
