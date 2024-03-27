//
//  SettingsVC.swift
//  TeacherNotes
//
//  Created by Büşra Erim on 16.01.2024.
//

import UIKit
import Firebase
import FirebaseFirestore

class SettingsVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logOutButton(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginVC {
                UIApplication.shared.windows.first?.rootViewController = loginViewController
                UIApplication.shared.windows.first?.makeKeyAndVisible()
            }
        } catch let signOutError as NSError {
            print("Oturumdan çıkış yapılırken hata oluştu: \(signOutError.localizedDescription)")
        }
    }
}
