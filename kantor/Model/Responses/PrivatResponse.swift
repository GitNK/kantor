import Foundation

struct PrivatResponse: Decodable {
    let base: String
    let dest: String
    let sell: String?
    let buy: String?

    private enum CodingKeys: String, CodingKey {
        case baseCurrency = "base_ccy"
        case destCurrency = "ccy"
        case sell = "sale"
        case buy = "buy"
    }
    // TODO: Same as in MONO
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        base = try container.decode(String.self, forKey: .baseCurrency)
        dest = try container.decode(String.self, forKey: .destCurrency)
        sell = try? container.decode(String.self, forKey: .sell)
        buy = try? container.decode(String.self, forKey: .buy)
    }
}
