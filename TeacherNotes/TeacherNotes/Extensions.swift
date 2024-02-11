//
//  Extensions.swift
//  TeacherNotes
//
//  Created by Büşra Erim on 24.01.2024.
//

import Foundation
import UIKit



extension UIViewController {
     func showAlert(title:String,message:String) {
        let buttonOK = UIAlertAction(title: "Tamam", style: .cancel)
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(buttonOK)
        self.present(alert, animated: true)
    }
}
