//
//  MenuInteractor.swift
//  MainPizzaScreen
//
//  Created by Vlad Ralovich on 03.04.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MenuBusinessLogic
{
    func doInteractor(request: Menu.Facestore.Request.RequestType)
}

protocol MenuDataStore
{
  //var name: String { get set }
}

class MenuInteractor: MenuBusinessLogic, MenuDataStore
{
  var presenter: MenuPresentationLogic?
  var worker: MenuWorker?
  private let servise: ServiceProtocol = Service()
  
  // MARK: Do something
  
    func doInteractor(request: Menu.Facestore.Request.RequestType)
  {
    worker = MenuWorker()
    worker?.doSomeWork()
    
      switch request {
      case .getProducts:
          servise.requestProducts { [weak self] data, error in
              self?.presenter?.presentResults(response: .presentProducts(data))
          }
      }
  }
}
