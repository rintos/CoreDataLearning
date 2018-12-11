//
//  ViewController.swift
//  CoreDataLearning
//
//  Created by Victor on 05/12/2018.
//  Copyright © 2018 Rinver. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        //agora preciso criar o produto
        let produto = NSEntityDescription.insertNewObject(forEntityName: "Produto", into: context)
        
        //acesso os atributos
        
        produto.setValue("Rx580", forKey: "nome")
        produto.setValue(300.28, forKey: "preco")
        produto.setValue(1, forKey: "quantidade")
        
        do {
            try context.save()
            print("salvou dados com sucesso")
        } catch  {
            print("nao pode salvar")
        }*/
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        // criar requisicao
        let resultProduto = NSFetchRequest<NSFetchRequestResult>(entityName: "Produto")
        
        //Ordernar de A-Z
        let ordenacaoAZ = NSSortDescriptor(key: "nome", ascending: false)
        //let ordenacaoZA = NSSortDescriptor(key: "preco", ascending: true)
        
        //aplicar filtro em item
       // let predicate = NSPredicate(format: "nome == %@", "Ipad")
        let predicate = NSPredicate(format: "nome contains [c] %@", "ip")
        
        
        //aplicar filtro criados a requisicao
        resultProduto.sortDescriptors = [ordenacaoAZ]
        resultProduto.predicate = predicate
        
        
        
        do {
            let produtos = try context.fetch(resultProduto)
            
            if produtos.count > 0 {
                
                for produto in produtos as! [NSManagedObject] {
                    if let nome = produto.value(forKey: "nome") {
                        if let quantidade = produto.value(forKey: "quantidade") {
                            if let preco = produto.value(forKey: "preco") {
                                
                                print("o nome eh \(nome) a sua quantidade eh \(quantidade) o preco eh: \(preco)" )
                            }
                        }
                    }
                }
                
            }
        }catch  {
            print(error)
        }
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

