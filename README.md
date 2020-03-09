## ToDo
* Round Doubles

# Quick Guide
## Model
- **Currency** is a model of the object that represents currency
- **ServiceRequest** is a class that creates requests and handle it into json.
- **Responses** are the parsed model of the objects from request's json.


## View
- **MainViewController** is the main View in the app.
- **CurrencyCell** is the View which is representing on the MainViewController in TableView


## Presenter
- **CurrencyPresenter** is responsible for handling business data and communication between Model and View


## Factory
- **CurrencyFactory** is the place, where we transform objects from the Reponse Model to Currency Model
