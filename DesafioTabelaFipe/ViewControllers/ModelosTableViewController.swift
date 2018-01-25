//
//  ModelosTableViewController.swift
//  DesafioTabelaFipe
//
//  Created by Swift on 23/01/2018.
//  Copyright © 2018 Quaddro. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ModelosTableViewController: UITableViewController {
    
    // MARK: - Propriedades
    //https://fipeapi.appspot.com/api/1/carros/veiculo/21/4828.json
    let urlModelos = "https://fipeapi.appspot.com/api/1/carros/veiculo/"
    var veiculoSelecionado = Veiculo()
    var idMarcaSelecionada = 0
    var arrayModelos: [Modelo] = []
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.carregarModelos()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.arrayModelos.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = self.arrayModelos[indexPath.row].nome
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let modeloSelecionado = self.arrayModelos[indexPath.row]
        performSegue(withIdentifier: "segueCarros", sender: modeloSelecionado)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let proximoViewController = segue.destination as?  CarrosTableViewController else { return }
        guard let newSender = sender as? Modelo else { return }
        proximoViewController.modeloSelecionado = newSender
        proximoViewController.idMarcaSelecionada = self.idMarcaSelecionada
        proximoViewController.idVeiculoSelecionado = self.veiculoSelecionado.id!
    }
    
    // MARK: - Métodos Próprios
    func carregarModelos() {

        let idMarca = String(self.idMarcaSelecionada)
        let idModelo = self.veiculoSelecionado.id!
        let urlCompleta = self.urlModelos + idMarca + "/" + idModelo + ".json"

        Alamofire.request(urlCompleta, method: .get).validate().responseJSON { (resposta) in
            
            switch resposta.result {
                
            case .success(let value):
                
                let json = JSON(value)
                for (_, subJson) in json {
                    let modelo =  Modelo(json: JSON(subJson))
                    self.arrayModelos.append(modelo)
                }
                self.tableView.reloadData()
                
            case .failure(let error):
                
                let alerta = UIAlertController(title: "Aviso", message: "Erro no retorno do request: \(error)", preferredStyle: .alert)
                let acaoOK = UIAlertAction(title: "OK", style: .default, handler: nil)
                alerta.addAction(acaoOK)
                self.present(alerta, animated: true, completion: nil)
                
            }
            
        }
        
    }
    
}

