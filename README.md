# SAE-Mobile-Restaurant

## Membres

Alexandre Guihard

Antoine Delahaye

Romain Voivenel

Amin El Mellouki

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

Connexion possible avec le compte ```Alice123``` et le mot de passe ```passAlice```

Affichage des restaurants et des types de cuisine récupérés dans la base de données Supabase

Recherche par nom ou par note

Triage par nom et par note

Possibilité de noter un restaurant

Ajout de restaurants et de types de cuisine aux favoris

Les favoris sont stockés en local via une base de données Sqflite

Accès à une page "Mon profil" permettant de voir tous les restaurants et types de cuisine ajoutés en favoris.
