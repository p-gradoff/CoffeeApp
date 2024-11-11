//
//  ListPresenter.swift
//  CoffeeApp
//
//  Created by Павел Градов on 08.11.2024.
//

import Foundation

protocol ListPresenterInput {
    var output: ListPresenterOutput! { get }
}

protocol ListPresenterOutput { }

final class ListPresenter {
    private let interactor: ListInteractorInput
    private let router: ListRouterInput
    private let view: ListViewInput
    
    init(interactor: ListInteractorInput, router: ListRouterInput, view: ListViewInput) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
}

extension ListPresenter: ListViewOutput {
    func getShopsInfo() {
        interactor.getDistances()
    }
}

extension ListPresenter: ListInteractorOutput {
    func sendShopsInfo(_ info: [ShopInfo]) {
        view.shopsInfo = info
    }
    
    func sendError(with title: String, _ message: String) {
        view.presentAlertController(with: title, message)
    }
}

