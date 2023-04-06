//
//  MenuModels.swift
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

enum Menu
{
  // MARK: Use cases
  
  enum Facestore
  {
    struct Request
    {
        enum RequestType {
            case getProducts
        }
    }
    struct Response
    {
        enum ResponseType {
            case presentProducts(_ : Data?)
        }
    }
    struct ViewModel
    {
        enum viewModelData {
            case products(_ : MenuController)
        }
    }
  }
}
