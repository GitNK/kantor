import Alamofire
import BrightFutures

enum Constants {
    enum BankNameURL: String {
        case mono = "https://api.monobank.ua/bank/currency"
        case privat = "https://api.privatbank.ua/p24api/pubinfo?json&exchange&coursid=5"
    }
}

class ServiceRequest {
    // TODO: What do you need `type` parameter for?
    func create<T: Decodable>(url: Constants.BankNameURL, type: T.Type) -> Future<[T], Error> {
        return Future { complete in
            // TODO: if `BankNameURL` would be `struct` you won't need to use `rawValue`
            guard let urlRequest = URL(string: url.rawValue) else {
                return
            }

            AF.request(urlRequest).response { response in
                guard let data = response.data, response.error == nil else {
                    // TODO: What will happen when both `response.data` and `response.error` is nil? :)
                    // Consider changing for checking presence of either error or data, since when there is data 
                    // we don't expect to receive error and vice-versa
                    
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
