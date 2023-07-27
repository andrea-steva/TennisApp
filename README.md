# Tennis app
  
## 📱 TennisApp

To run the project, clone the repo, open with Xcode and run from `TennisApp` target. To run unit tests type `CMD + U`

## 📌 Requirements

+ Xcode 15+
+ Swift 5.7+
+ Deployment target iOS 15+

## ⚙️ Tools

+ **Swiftlint** to enhance code styling

You can install those tools from terminal:

```bash
brew update
brew install swiftlint
```

## 🔨 TODO / Improvements

+ [] Add forms for activities
+ [] Complete SignUp page
+ [] Add DTO to decouple domain model from CoreDataStorage
+ [] Entity relationships
+ [] Add builder to convert form to Model (formValues -> ´Rackets´)
+ [] Convert repository with async/await
+ [] See https://github.com/AvdLee/StockAnalyzerApp for Terms and Privacy
+ [~] Use [Modern cell configuration](https://developer.apple.com/videos/play/wwdc2020/10027/)
+ [~] Create repositories
+ [~] Create UseCases
+ [~] CRUD operation for User, Match and others
+ [X] Implementing Modern Collection Views (https://swiftsenpai.com/development/uicollectionview-list-basic/) instead of UITableView
+ [X] Add Design Library
+ [X] Refactor localization
+ [X] Add DI containers
+ [X] Create domain model
+ [X] Rename RealmStorage protocols
+ [X] Remove Realm and use CoreData
+ [X] Split Storyboard (use one storyboard for each controller)
+ [X] RacketFormViewModel refactor using Racket instead RacketEntity
+ [X] Remove FontAwesome
+ [X] Remove MBProgressHUD
+ [X] Use TabBarController instead of RESideMenu
+ [X] CRUD operation for Racket
+ [X] `FirebaseService` add `Result` type instead of completion block
+ [X] Use Combine instead of Bond
+ [X] Remove `SCLAlertView`


## ✒️ Author

Andrea Stevanato
