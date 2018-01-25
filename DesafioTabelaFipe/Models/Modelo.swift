//
//  Modelo.swift
//  DesafioTabelaFipe
//
//  Created by MacBook White on 24/01/18.
//  Copyright © 2018 Quaddro. All rights reserved.
//

import UIKit
import SwiftyJSON

class Modelo: NSObject {
    
    var nome: String?
    var id: String?
    
    convenience init(json: JSON) {
        self.init()
        
        if let nome = json["name"].string {
            self.nome = nome
        }
        
        if let id = json["id"].string {
            self.id = id
        }
    }
    


}
