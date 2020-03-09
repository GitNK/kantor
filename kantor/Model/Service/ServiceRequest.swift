import Alamofire
import BrightFutures

enum Constants {
    enum BankNameURL: String {
        case mono = "https://api.monobank.ua/bank/currency"
        case privat = "https://api.privatbank.ua/p24api/pubinfo?json&exchange&coursid=5"
    }
}

class ServiceRequest {
    func create<T: Decodable>(url: Constants.BankNameURL, type: T.Type) -> Future<[T], Error> {
        return Future { complete in
            guard let urlRequest = URL(string: url.rawValue) else {
                return
            }

            AF.request(urlRequest).response { response in
                guard let data = response.data, response.error == nil else {
                    complete(.failure(response.error!))
                    return
                }

                do {
                    let response = try JSONDecoder().decode([T].self, from: data)
                    complete(.success(response))
                } catch {
                    complete(.failure(error))
                }
            }
        }

    }
}
