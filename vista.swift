//
//  vista.swift
//  scaner
//
//  Created by ine on 08/11/16.
//  Copyright © 2016 saint. All rights reserved.
//

import UIKit

class vista: UIViewController,TransferirTexto {
    
    @IBOutlet weak var inputText: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func transferir(texto: String) {
        inputText.text = texto
        print("==================================",texto)
    }

    @IBAction func activaScaner(_ sender: Any) {
        let scaner = ScannerViewController()
        scaner.delegate = self
        self.present(scaner, animated: true, completion: nil)
    }
    
}
