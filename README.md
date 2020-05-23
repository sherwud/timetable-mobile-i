# timetable-mobile-i
iOS app for tensor it crowd

## Getting started


### Подключаем зависимости из pods

Устанавливаем [CocoaPods](https://cocoapods.org/ "Менеджер зависимостей")

Устанавливаем [Realm](https://realm.io/ "Локальная БД на вашем устройстве")

Открывааем корень проекта в консоли и запускаем команду
    pod init

Так будут подключены:
- локальная БД Realm
- SwiftyJSON

Если что то пошло не так:
    pod deintegrate

### Открытие проекта

Открываем проект заново в xcode, через файл проекта timetable-mobile-i.xcworkspace
> При работе без pods, xcode выбирает timetable-mobile-i.xcodeproj
