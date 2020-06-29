//
//  TextFieldMascarado.swift
//  testeMascara
//
//  Created by humberto Lima on 29/06/20.
//  Copyright © 2020 humberto Lima. All rights reserved.
//

import UIKit

//self.campoTexto.delegate = self
//self.campoTexto.TipoMascaraUsar = 1

extension UITextField {
    private static var _TipoMascaraUsar = [String:Int]()
    var TipoMascaraUsar:Int {
        get {
            let endereco = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return UITextField._TipoMascaraUsar[endereco] ?? 0
        }
        set(newValue){
            let endereco = String(format: "%p", unsafeBitCast(self, to: Int.self))
            UITextField._TipoMascaraUsar[endereco] = newValue
        }
    }
}

extension UIViewController: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if (isBackSpace == -92) && (textField.text?.count)! > 0 {
            textField.text!.removeLast()
            return false
        }
        
        if textField.TipoMascaraUsar == 1 {
            if (textField.text?.count)! == 1 {
                if (textField.text?.contains("(") ?? false) {
                    textField.text = ""
                }
            }else if (textField.text?.count)! == 2 {
                if (textField.text?.contains("(") ?? false) {
                    textField.text = ""
                }else{
                    textField.text = "(\(textField.text!)) "
                }
            } else if (textField.text?.count)! == 9 {
                textField.text = "\(textField.text!)-" //there we are ading - in textfield
                
            } else if (textField.text?.count)! > 13 {
                return false
            }else{
                return true
            }
            return true
        }else if textField.TipoMascaraUsar == 2 {
            if (textField.text?.count)! == 1 {
                textField.text = "R$ \(textField.text!)"
            }else if (textField.text?.count)! == 10 {
                textField.text = "\(textField.text!),"
            } else if (textField.text?.count)! > 12 {
                return false
            }else{
                return true
            }
            return true
        }else{
            return true
        }
    }
}
