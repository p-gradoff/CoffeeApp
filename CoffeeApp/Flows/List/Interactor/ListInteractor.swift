//
//  ListInteractor.swift
//  CoffeeApp
//
//  Created by Павел Градов on 08.11.2024.
//

import Foundation

protocol ListInteractorInput: AnyObject {
    var output: ListInteractorOutput? { get }
    func calculateDistance()
}

protocol ListInteractorOutput: AnyObject {
    func getDistance(km: Int)
}

final class ListInteractor {
    weak var output: ListInteractorOutput?
    
    
}

extension ListInteractor: ListInteractorInput {
    func calculateDistance() {
        //
    }
}
