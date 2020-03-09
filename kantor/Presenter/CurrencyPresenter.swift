import Foundation
import BrightFutures

protocol CurrencyDelegate: class {
    func showError(error: String)
    func showCurrencies(mono: Currency?, privat: Currency?)
}

class CurrencyPresenter {

    weak private var delegate: CurrencyDelegate?

    private let serviceRequest = ServiceRequest()

    func setViewDelegate(delegate: CurrencyDelegate) {
        self.delegate = delegate
    }

    func getDataSync() {
        let monoRequest = serviceRequest.create(url: .mono, type: MonoResponse.self)
        let privatRequest = serviceRequest.create(url: .privat, type: PrivatResponse.self)
        let factory = CurrencyFactory()

        monoRequest.zip(privatRequest).onSuccess { mono, privat in

            let monoBankDataToDisplay = factory.make(from: mono)
            let privatBankDataToDisplay = factory.make(from: privat)

            self.delegate?.showCurrencies(mono: monoBankDataToDisplay,
                                          privat: privatBankDataToDisplay)
            print("sync")
        }.onFailure { [weak self] error in
            self?.delegate?.showError(error: error.localizedDescription)
        }
    }

    func getDataAsync() {
        let monoRequest = serviceRequest.create(url: .mono, type: MonoResponse.self)
        let privatRequest = serviceRequest.create(url: .privat, type: PrivatResponse.self)
        let factory = CurrencyFactory()

        monoRequest.onSuccess { [weak self] mono in
            let monoBankDataToDisplay = factory.make(from: mono)
            self?.delegate?.showCurrencies(mono: monoBankDataToDisplay,
                                          privat: nil)
            print("mono async")
        }.onFailure { [weak self] error in
            self?.delegate?.showError(error: error.localizedDescription)
        }

        privatRequest.onSuccess { [weak self] privat in
            let privatBankDataToDisplay = factory.make(from: privat)
            self?.delegate?.showCurrencies(mono: nil,
                                           privat: privatBankDataToDisplay)
            print("privat async")
        }.onFailure { [weak self] error in
            self?.delegate?.showError(error: error.localizedDescription)
        }
    }

}
