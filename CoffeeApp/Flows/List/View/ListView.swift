//
//  LocationView.swift
//  CoffeeApp
//
//  Created by Павел Градов on 06.11.2024.
//

import UIKit

protocol ListViewInput: AnyObject {
    var output: ListViewOutput? { get set }
    var shopsInfo: [ShopInfo] { get set }
    func presentAlertController(with title: String, _ message: String)
}

protocol ListViewOutput: AnyObject {
    func getShopsInfo()
}

final class ListView: UIViewController, UITableViewDataSource {
    
    var output: ListViewOutput?
    var shopsInfo: [ShopInfo] = []
    // private var tableData: [ShopInfo]?
    
    private lazy var tableView: UITableView = {
        $0.dataSource = self
        $0.separatorStyle = .none
        $0.register(TableCell.self, forCellReuseIdentifier: TableCell.reuseID)
        // $0.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        return $0
    }(UITableView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ближайшие кофейни"
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shopsInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableData = shopsInfo
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.reuseID, for: indexPath) as? TableCell else {
            return UITableViewCell()
        }
    
        let item = tableData[indexPath.row]
        cell.setupCell(with: item.name, distance: item.distance)
        return cell
    }
}

extension ListView: ListViewInput, AlertProvider {
    func presentAlertController(with title: String, _ message: String) {
        let controller = getController(with: title, message)
        self.present(controller, animated: true)
    }
}
