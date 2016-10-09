//
//  ViewController.swift
//  Couch
//
//  Created by Abhinash Khanal on 10/9/16.
//  Copyright © 2016 Moonlighting. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.crudtest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func crudtest() {
        let manager: CBLManager = CBLManager()
        do {
            let database = try manager.databaseNamed("stuff")
            let document = database.document(withID: "1234")
            guard let doc = document else {
                return
            }
            var properties = [String: Any]()
            properties["name"] = "Awesome!"
            try doc.putProperties(properties)
            
            let newDoc = database.existingDocument(withID: "1234")
            print(newDoc)
            print(newDoc?.property(forKey: "name"))
            
            guard let newProp = newDoc?.properties else {
                return
            }
            
            properties = newProp
            properties["name"] = "Everything is"
            try newDoc?.putProperties(properties)
            
            let newDoc1 = database.existingDocument(withID: "1234")
            print(newDoc1?.property(forKey: "name"))
            
            try newDoc1?.delete()
            let newDoc2 = database.existingDocument(withID: "1234")
            
            print(newDoc2)
            
            try database.close()

            
        } catch let error as NSError {
            print(error)
        }
    }


}

