import Foundation

enum TypeMono: Int {
    case uah = 980
    case usd = 840
    case eur = 978
    case rub = 643
}

enum TypePrivat: String {
    case uah = "UAH"
    case usd = "USD"
    case eur = "EUR"
    case rub = "RUR"
}

struct CurrencyFactory {

    func make(from mono: [MonoResponse]) -> Currency? {

        guard let usd = mono.filter( { $0.base == TypeMono.usd.rawValue && $0.dest == TypeMono.uah.rawValue } ).first,
            let eur = mono.filter( { $0.base == TypeMono.eur.rawValue && $0.dest == TypeMono.uah.rawValue } ).first,
            let rub = mono.filter( { $0.base == TypeMono.rub.rawValue && $0.dest == TypeMono.uah.rawValue } ).first else {
                return nil
        }

        guard let usdSell = usd.sell, let eurSell = eur.sell, let rubSell = rub.sell,
            let usdBuy = usd.buy, let eurBuy = eur.buy, let rubBuy = rub.buy else{
            return nil
        }

        return Currency(name: "Монобанк",
                        usdSell: "\(usdSell)", usdBuy: "\(usdBuy)",
                        eurSell: "\(eurSell)", eurBuy: "\(eurBuy)",
                        rubSell: "\(rubSell)", rubBuy: "\(rubBuy)")
    }

    func make(from privat: [PrivatResponse]) -> Currency? {

        guard let usd = privat.filter( { $0.base == TypePrivat.uah.rawValue && $0.dest == TypePrivat.usd.rawValue } ).first,
            let eur = privat.filter( { $0.base == TypePrivat.uah.rawValue && $0.dest == TypePrivat.eur.rawValue } ).first,
            let rub = privat.filter( { $0.base == TypePrivat.uah.rawValue && $0.dest == TypePrivat.rub.rawValue } ).first else {
                return nil
        }

        guard let usdSell = usd.sell, let eurSell = eur.sell, let rubSell = rub.sell,
            let usdBuy = usd.buy, let eurBuy = eur.buy, let rubBuy = rub.buy else{
            return nil
        }

        return Currency(name: "ПриватБанк",
                        usdSell: usdSell, usdBuy: usdBuy,
                        eurSell: eurSell, eurBuy: eurBuy,
                        rubSell: rubSell, rubBuy: rubBuy)
    }
}
