# Tennis app
  
## 📱 TennisApp

To run the project, clone the repo, open with Xcode and run from `TennisApp` target. To run unit tests type `CMD + U`

## 📌 Requirements

+ Xcode 14+
+ Swift 5.7+
+ Deployment target iOS 13+

## ⚙️ Tools

+ **Swiftlint** to enhance code styling

You can install those tools from terminal:

```bash
brew update
brew install swiftlint
```

## 🔨 TODO / Improvements

+ [X] Create domain model
+ [X] Rename RealmStorage protocols
+ [X] Remove Realm and use CoreData
+ [X] Split Storyboard (use one storyboard for each controller)
+ [X] RacketFormViewModel refactor using Racket instead RacketEntity
+ [X] Remove FontAwesome
+ [~] Add DI containers
+ [~] Create repositories
+ [~] Create UseCases
+ [~] CRUD operation for Racket
+ [~] CRUD operation for User

+ [] Add DTO to decouple domain model from CoreDataStoreage
+ [~] Check Utilities folder

+ [] Use TabBarController instead of RESideMenu
## ✒️ Author

Andrea Stevanato
