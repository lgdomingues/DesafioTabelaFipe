//
//  Veiculo.swift
//  DesafioTabelaFipe
//
//  Created by Swift on 23/01/2018.
//  Copyright © 2018 Quaddro. All rights reserved.
//

import UIKit
import SwiftyJSON

class Veiculo: NSObject {

    var nome: String?
    var id: String?
//    var idMarca: Int?
    
    convenience init(json: JSON) {
        self.init()
        
        if let nome = json["fipe_name"].string {
            self.nome = nome
        }

        if let id = json["id"].string {
            self.id = id
        }
        
//        if let idMarca = json[].int {
//            self.idMarca = idMarca
//        }
    }
    
}
