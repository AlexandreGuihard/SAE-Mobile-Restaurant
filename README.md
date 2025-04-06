# SAE-Mobile-Restaurant

## Installation et lancement
Avant de commencer, assurez-vous que flutter et dart sont disponible sur votre ordinateur

Sur votre terminal
```shell
git clone https://github.com/AlexandreGuihard/SAE-Mobile-Restaurant
```

Puis déplacez-vous dans le dossier du projet avec

```shell
cd SAE-Mobile-Restaurant
```

Récuperez les dépendances avec la commande

```shell
flutter pub get
```

Initialisez la librairie sqflite avec la commande :
```shell
dart run sqflite_common_ffi_web:setup
```

Lancez l'application en faisant

```shell
flutter run -d chrome
```

## Fonctionnalité implémentées

Il est possible de se connecter avec le compte ```Alice123``` et le mot de passe ```passAlice```

Il est possible de voir les restaurants et types de cuisine stocké dans la base de données supabase

Il est possible de rechercher un restaurant selon son nom

Il est possible d'ordonner les restaurants selon leur nom ou selon leur note

Il est possible de noter un restaurant

Il est possible de mettre en favoris des restaurants et des types de cuisine stocké dans une base de données locale sqflite

Il est possible de voir les restaurants et types de cuisine en favoris dans la page ```mon profil```