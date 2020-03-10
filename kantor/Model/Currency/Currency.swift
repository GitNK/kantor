import Foundation

// TODO: We can avoid enumarating each currency and generilize for better scaling in future:
/* struct CurrencyExchange {
    let name: String
    let base: Currency
    let sell: [Currency]
    let buy: [Currency]
   }

   struct Currency {
       let name: String // "USD", "EUR", "UAH"
       let code: Int // could be arbitrary id like 1,2...
       let price: Double
   }
*/
// custom sorting could be done by `code` or `name`
struct Currency {
    let name: String
    let usdSell: String
    let usdBuy: String
    let eurSell: String
    let eurBuy: String
    let rubSell: String
    let rubBuy: String
}
