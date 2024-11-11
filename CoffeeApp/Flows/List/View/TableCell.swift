//
//  TableCell.swift
//  CoffeeApp
//
//  Created by Павел Градов on 09.11.2024.
//

import Foundation
import UIKit
import SnapKit

final class TableCell: UITableViewCell {
    static let reuseID: String = UUID().uuidString
    
    private lazy var cellView: UIView = {
        $0.layer.cornerRadius = 5
        $0.backgroundColor = .cellFilling
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.3
        return $0
    }(UIView())
    
    private lazy var nameLabel: UILabel = {
        $0.textColor = .primaryText
        $0.textAlignment = .left
        $0.font = .getFont(fontType: .displayBold, size: 18)
        return $0
    }(UILabel())
    
    private lazy var distanceLabel: UILabel = {
        $0.textColor = .placeholder
        $0.textAlignment = .left
        $0.font = .getFont(fontType: .displayRegular, size: 14)
        return $0
    }(UILabel())
    
    func setupCell(with name: String, distance: String) {
        nameLabel.text = name
        distanceLabel.text = distance
        
        backgroundColor = .gray
        cellView.addSubviews(nameLabel, distanceLabel)
        addSubview(cellView)
        
        cellView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-6)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(14)
            $0.horizontalEdges.equalToSuperview().inset(10)
        }
        
        distanceLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(6)
            $0.horizontalEdges.equalTo(nameLabel)
        }
    }
}
