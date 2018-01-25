//
//  VeiculosTableViewController.swift
//  DesafioTabelaFipe
//
//  Created by Swift on 23/01/2018.
//  Copyright © 2018 Quaddro. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class VeiculosTableViewController: UITableViewController {

    // MARK: - Propriedades
    //http://fipeapi.appspot.com/api/1/carros/veiculos/21.json
    let urlVeiculos = "https://fipeapi.appspot.com/api/1/carros/veiculos/"
    var marcaSelecionada = Marca()
    var arrayVeiculos: [Veiculo] = []
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.carregarVeiculos()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.arrayVeiculos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = self.arrayVeiculos[indexPath.row].nome

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let veiculoSelecionado = self.arrayVeiculos[indexPath.row]
        performSegue(withIdentifier: "segueModelos", sender: veiculoSelecionado)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let proximoViewController = segue.destination as?  ModelosTableViewController else { return }
        guard let newSender = sender as? Veiculo else { return }
        proximoViewController.veiculoSelecionado = newSender
        proximoViewController.idMarcaSelecionada = self.marcaSelecionada.id!
    }
    
    // MARK: - Métodos Próprios
    func carregarVeiculos() {
        
        let idVeiculo = String(describing: self.marcaSelecionada.id!)
        let urlCompleta = self.urlVeiculos + idVeiculo + ".json"

        Alamofire.request(urlCompleta, method: .get).validate().responseJSON { (resposta) in
            
            switch resposta.result {
                
            case .success(let value):
                
                let json = JSON(value)
                for (_, subJson) in json {
                    let veiculo =  Veiculo(json: JSON(subJson))
                    self.arrayVeiculos.append(veiculo)
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
