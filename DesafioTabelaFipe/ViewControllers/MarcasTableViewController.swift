//
//  MarcasTableViewController.swift
//  DesafioTabelaFipe
//
//  Created by Swift on 23/01/2018.
//  Copyright © 2018 Quaddro. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MarcasTableViewController: UITableViewController {

    // MARK: - Propriedades
    let urlMarcas = "https://fipeapi.appspot.com/api/1/carros/marcas.json"
    var arrayMarcas: [Marca] = []
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.carregarMarcas()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (self.arrayMarcas.count)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = self.arrayMarcas[indexPath.row].nome

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let marcaSelecionada = self.arrayMarcas[indexPath.row]
        performSegue(withIdentifier: "segueVeiculos", sender: marcaSelecionada)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let proximoViewController = segue.destination as?  VeiculosTableViewController else { return }
        guard let newSender = sender as? Marca else { return }
        proximoViewController.marcaSelecionada = newSender
    }
    
    // MARK: - Métodos Próprios
    func carregarMarcas() {
        
        Alamofire.request(urlMarcas, method: .get).validate().responseJSON { (resposta) in
            
            switch resposta.result {
                
            case .success(let value):
                
                let json = JSON(value)
                for (_, subJson) in json {
                    let marca = Marca(json: JSON(subJson))
                    self.arrayMarcas.append(marca)
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
