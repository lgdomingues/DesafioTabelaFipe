//
//  Marca.swift
//  DesafioTabelaFipe
//
//  Created by Swift on 23/01/2018.
//  Copyright © 2018 Quaddro. All rights reserved.
//

import UIKit
import SwiftyJSON

class Marca: NSObject {

    var nome: String?
    var id: Int?
    
    convenience init(json: JSON) {
        self.init()
        
        if let nome = json["fipe_name"].string {
            self.nome = nome
        }
        
        if let id = json["id"].int {
            self.id = id
        }
    }
    
}
