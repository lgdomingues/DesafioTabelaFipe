//
//  Carro.swift
//  DesafioTabelaFipe
//
//  Created by MacBook White on 25/01/18.
//  Copyright © 2018 Quaddro. All rights reserved.
//

import UIKit
import SwiftyJSON

class Carro: NSObject {

    var ano: String?
    var marca: String?
    var nome: String?
    var combustivel: String?
    var referencia: String?
    var preco: String?
    
    convenience init(json: JSON) {
        self.init()
        
        if let ano = json["ano_modelo"].string {
            self.ano = ano
        }
        
        if let marca = json["marca"].string {
            self.marca = marca
        }
        
        if let nome = json["name"].string {
            self.nome = nome
        }
        
        if let combustivel = json["combustivel"].string {
            self.combustivel = combustivel
        }
        
        if let referencia = json["referencia"].string {
            self.referencia = referencia
        }

        if let preco = json["preco"].string {
            self.preco = preco
        }
        
    }
    
}
