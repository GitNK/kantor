import UIKit

class CurrencyCell: UITableViewCell {

    static let identifier = "currencyCell"
    static let nibName = "CurrencyCell"

    @IBOutlet private weak var bankName: UILabel!
    
    @IBOutlet private weak var usdSell: UILabel!
    @IBOutlet private weak var usdBuy: UILabel!

    @IBOutlet private weak var eurSell: UILabel!
    @IBOutlet private weak var eurBuy: UILabel!

    @IBOutlet private weak var rubSell: UILabel!
    @IBOutlet private weak var rubBuy: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(currency: Currency) {
        bankName.text = "\(currency.name)"
        usdSell.text = "\(currency.usdSell)"
        usdBuy.text = "\(currency.usdBuy)"

        eurSell.text = "\(currency.eurSell)"
        eurBuy.text = "\(currency.eurBuy)"

        rubSell.text = "\(currency.rubSell)"
        rubBuy.text = "\(currency.rubBuy)"

    }
}
