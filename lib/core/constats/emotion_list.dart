import 'package:mood_dairy/generated/assets.dart';
import 'package:mood_dairy/model/emotion_menu_model.dart';

class EmotionList {
  List<EmotionMenuModel> emotionList() => _emotionList;

  List<String> extraEmo() => _extraEmo;

  final List<EmotionMenuModel> _emotionList = [
    EmotionMenuModel(title: 'Радость', image: Assets.imagesHappyBunny),
    EmotionMenuModel(title: 'Страх', image: Assets.imagesScaredRabbit),
    EmotionMenuModel(title: 'Бешенство', image: Assets.imagesRabidRabbit),
    EmotionMenuModel(title: 'Грусть', image: Assets.imagesSadRabbit),
    EmotionMenuModel(title: 'Спокойствие', image: Assets.imagesCalmRabbit),
    EmotionMenuModel(title: 'Сила', image: Assets.imagesStrongRabbit),
  ];

  final List<String> _extraEmo = [
    'Возбуждение',
    'Восторг',
    'Игривость',
    'Наслаждение',
    'Очарование',
    'Осознанность',
    'Смелость',
    'Удовольствие',
    'Чувственность',
    'Энергичность',
    'Экстравагантность',
  ];
}
