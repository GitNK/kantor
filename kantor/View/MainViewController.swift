import UIKit

class MainViewController: UIViewController {

    private let mainPresenter = CurrencyPresenter()

    private var monoCurrency: Currency?
    private var privatCurrency: Currency?
    private var sync: Bool = true

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: CurrencyCell.nibName, bundle: nil), forCellReuseIdentifier: CurrencyCell.identifier)
            tableView.dataSource = self
            tableView.allowsSelection = false
            tableView.separatorStyle = .none
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(getData))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "sync", style: .plain, target: self, action: #selector(changeOrder))
        mainPresenter.setViewDelegate(delegate: self)
        mainPresenter.getDataSync()
    }

    @objc private func getData() {
        sync ? mainPresenter.getDataSync() : mainPresenter.getDataAsync()
    }

    @objc private func changeOrder() {
        if sync {
            navigationItem.leftBarButtonItem?.title = "async"
            sync = false
        } else {
            navigationItem.leftBarButtonItem?.title = "sync"
            sync = true
        }
    }
}

extension MainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyCell.identifier) as! CurrencyCell
        if indexPath.row == 0 {
            if let monoCurrency = monoCurrency {
                cell.configure(currency: monoCurrency)
            } else if let privatCurrency = privatCurrency {
                cell.configure(currency: privatCurrency)
            }
        } else if indexPath.row == 1 {
            if let privatCurrency = privatCurrency {
                cell.configure(currency: privatCurrency)
            }
        }
        return cell
    }
}

extension MainViewController: CurrencyDelegate {

    func showCurrencies(mono: Currency?, privat: Currency?) {
        if let mono = mono {
            monoCurrency = mono
        }

        if let privat = privat {
            privatCurrency = privat
        }

        tableView.reloadData()
    }

    func showError(error: String) {
        let alert = UIAlertController(title: "Error",
                                      message: error,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            alert.dismiss(animated: true)
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
}
