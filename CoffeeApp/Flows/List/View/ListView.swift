//
//  LocationView.swift
//  CoffeeApp
//
//  Created by Павел Градов on 06.11.2024.
//

import UIKit
import SnapKit

protocol ListViewInput: AnyObject {
    var output: ListViewOutput? { get set }
    var shopsInfo: [ShopInfo] { get set }
    func presentAlertController(with title: String, _ message: String)
}

protocol ListViewOutput: AnyObject {
    func getShopsInfo()
}

final class ListView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var output: ListViewOutput?
    private let interfaceBuilder: ButtonBuilder
    private var tableData: [ShopInfo] = []
    
    private lazy var tableView: UITableView = {
        $0.backgroundColor = .lightGray
        $0.dataSource = self
        $0.delegate = self
        $0.separatorStyle = .none
        $0.register(TableCell.self, forCellReuseIdentifier: TableCell.reuseID)
        // $0.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        return $0
    }(UITableView())
    
    private lazy var mapButton: UIButton = interfaceBuilder.createButton(withTitle: ButtonTitle.map.rawValue)
    
    init(interfaceBuilder: ButtonBuilder) {
        self.interfaceBuilder = interfaceBuilder
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ближайшие кофейни"
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubviews(tableView, mapButton)
        
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.height.equalTo(567)
        }
        
        mapButton.snp.makeConstraints {
            $0.top.equalTo(tableView.snp.bottom).offset(32)
            $0.horizontalEdges.equalToSuperview().inset(19)
            $0.height.equalTo(48)
        }
    }
    
    // MARK: - TableView DataSource & Delegate methods
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 76 }
}

extension ListView: ListViewInput, AlertProvider {
    var shopsInfo: [ShopInfo] {
        get {
            output?.getShopsInfo()
            return tableData
        }
        set {
            tableData = newValue
            tableView.reloadData()
            print(tableData)
        }
    }
    
    func presentAlertController(with title: String, _ message: String) {
        let controller = getController(with: title, message)
        self.present(controller, animated: true)
    }
}
