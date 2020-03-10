import Foundation

struct MonoResponse: Decodable {
    let base: Int
    let dest: Int
    let sell: Double?
    let buy: Double?

    private enum CodingKeys: String, CodingKey {
        case baseCurrency = "currencyCodeA"
        case destCurrency = "currencyCodeB"
        case sell = "rateSell"
        case buy = "rateBuy"
    }
    // TODO: This is redundant since it is automatically generated
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        base = try container.decode(Int.self, forKey: .baseCurrency)
        dest = try container.decode(Int.self, forKey: .destCurrency)
        sell = try? container.decode(Double.self, forKey: .sell)
        buy = try? container.decode(Double.self, forKey: .buy)
    }
}
