import 'package:color_picker/lang/lang.dart';
import 'package:flutter/material.dart';

class Portuguese extends Language {
  String get code => 'pt';
  String get langName => 'Português';

  String get title => 'Seletor de cores';

  String get wheelPicker => 'Roda';
  String get palettePicker => 'Paleta';
  String get valuePicker => 'Valores';
  String get namedPicker => 'Nomes';
  String get imagePicker => 'Imagens';

  String get red => 'Vermelho (Red)';
  String get green => 'Verde (Green)';
  String get blue => 'Azul (Blue)';
  String get alpha => 'Alpha';

  String get hexCode => 'Código hexadecimal';
  String get hex => 'Hexadecimal';
  String get cssHex => 'Hexadecimal do CSS';
  String get clear => 'Limpar';
  String get hexCodeMustNotBeEmpty => 'Código hexadecimal não pode estar vazio';
  String get hexCodeLengthMustBeSix =>
      'O tamanho do código hexadecimal deve ser de 6 caracteres de 0 a 9 e de A a F';
  String get hexCodeLimitedChars =>
      'O código hexadecimal só pode ter caracteres de 0 a 9 e de A a F';
  String get hexCodeOpacity =>
      'Dica: a opacidade pode ser alterada pelo controle deslizante abaixo';

  String get hue => 'Matiz (Hue)';
  String get saturation => 'Saturação';
  String get lightness => 'Luminosidade';
  String get value => 'Valor';

  String get opacity => 'Opacidade';

  String get localImage => 'Imagem local';
  String get networkImage => 'Imagem da internet';
  String get selectPhoto => 'Selecionar imagem';

  String get favoriteColorsTitle => 'Cores favoritas';
  String get haventFavoritedAnyBefore =>
      'Você ainda não favoritou nenhuma cor!\nAperte ';
  String get haventFavoritedAnyAfter =>
      ' em uma previsualização de cor para favoritar';
  String get favorite => 'Favoritar';
  String get unfavorite => 'Desfavoritar';
  String get favorited => 'Favoritado';
  String get unfavorited => 'Desfavoritado';

  String get copyToClipboard => 'Copiar para a área de transferência';
  Widget copiedToClipboard(String text) {
    return RichText(
      text: TextSpan(
        text: '',
        children: [
          TextSpan(text: text, style: TextStyle(color: Colors.blue)),
          TextSpan(text: ' foi copiado para a área de transferência'),
        ],
      ),
    );
  }

  String supportedPlatforms(List<TargetPlatform> platforms) {
    String text = 'Essa funcionalidade não está disponível no seu dispositivo';
    return text;
  }

  String get seeColorInfo => 'Ver informações da cor';
  String get colorInfo => 'Informações da cor';
  String colorWithOpacity(String name, int opacity) =>
      '$name com $opacity% de opacidade';

  String get settings => 'Configurações';
  String get user => 'Usuário';
  String get app => 'Aplicativo';
  String get initialColor => 'Cor inicial';
  String get language => 'Idioma';

  String get open => 'Abrir';
  String get close => 'Fechar';

  String get about => 'Sobre';
  String get author => 'Autor';
  String get openSource => 'Código-aberto';
  String get madeWithFlutter => 'Feito com Flutter 💙';

  String get theme => 'Tema do aplicativo';
  String get dark => 'Escuro';
  String get light => 'Claro';
  String get system => 'Sistema (padrão)';

  String minHeight(int height) =>
      'Esta funcionalidade só está disponível em dispositivos com uma tela maior que $height pixels';

  String get update => 'Atualizar';
  String get initialColorUpdated => 'Cor inicial atualizada';

  String get url => 'Url';
  String get urlMustNotBeEmpty => 'A url não pode estar vazia';
  String get search => 'Procurar';

  String get redColor => 'Vermelho';
  String get pink => 'Rosa';
  String get purple => 'Roxo';
  String get deepPurple => 'Roxo escuro';
  String get indigo => 'Azul escuro';
  String get blueColor => 'Azul';
  String get lightBlue => 'Azul claro';
  String get cyan => 'Ciano';
  String get teal => 'Teal';
  String get grey => 'Cinza';
  String get blueGrey => 'Azul acinzentado';
  String get greenColor => 'Verde';
  String get lightGreen => 'Verde claro';
  String get lime => 'Verde limão';
  String get yellow => 'Amarelo';
  String get amber => 'Âmbar (Laranja-amarelo)';
  String get orange => 'Laranja';
  String get deepOrange => 'Laranja escuro';
  String get brown => 'Marrom';
}
