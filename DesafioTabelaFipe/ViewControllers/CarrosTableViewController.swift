//
//  CarrosTableViewController.swift
//  DesafioTabelaFipe
//
//  Created by MacBook White on 25/01/18.
//  Copyright © 2018 Quaddro. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CarrosTableViewController: UITableViewController {

    // MARK: - Propriedades
    // https://fipeapi.appspot.com/api/1/carros/veiculo/21/4828/2013-1.json
    let urlCarros = "https://fipeapi.appspot.com/api/1/carros/veiculo/"
    var modeloSelecionado = Modelo()
    var carro = Carro()
    var idMarcaSelecionada = 0
    var idVeiculoSelecionado = ""
    
    // MARK: - Outlets
    @IBOutlet weak var labelAno: UILabel!
    @IBOutlet weak var labelMarca: UILabel!
    @IBOutlet weak var labelNome: UILabel!
    @IBOutlet weak var labelCombustivel: UILabel!
    @IBOutlet weak var labelReferencia: UILabel!
    @IBOutlet weak var labelPreco: UILabel!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.buscarCarro()
        
    }
    
    // MARK: - Métodos Próprios
    func mostrarCarro(carro: Carro) {
        
        self.labelAno.text = carro.ano
        self.labelNome.text = carro.nome
        self.labelMarca.text = carro.marca
        self.labelPreco.text =  carro.preco
        self.labelReferencia.text = carro.referencia
        self.labelCombustivel.text = carro.combustivel
        
    }
    
    func buscarCarro() {
        
        let idMarca = String(self.idMarcaSelecionada)
        let idVeiculo = self.idVeiculoSelecionado
        let idModelo = self.modeloSelecionado.id!
        let urlCompleta = self.urlCarros + idMarca + "/" + idVeiculo + "/" + idModelo + ".json"

        Alamofire.request(urlCompleta, method: .get).validate().responseJSON { (resposta) in
            
            switch resposta.result {
            case .success(let value):

                let json = JSON(value)
                let carro = Carro(json: json)
                self.mostrarCarro(carro: carro)

            case .failure(let error):
                
                let alerta = UIAlertController(title: "Aviso", message: "Erro no retorno do request: \(error)", preferredStyle: .alert)
                let acaoOK = UIAlertAction(title: "OK", style: .default, handler: nil)
                alerta.addAction(acaoOK)
                self.present(alerta, animated: true, completion: nil)
                
            }

        }
    }
}
