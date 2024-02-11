//
//  ViewController.swift
//  TeacherNotes
//
//  Created by Büşra Erim on 8.01.2024.
//

import UIKit
import Firebase
import FirebaseFirestore

class LoginVC: UIViewController {
    
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var signUpLabel: UILabel!
    
    @IBOutlet weak var isSecureTextIV: UIImageView!
    
    @IBOutlet weak var scroll: UIScrollView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.delegate = self
        password.delegate = self
        gesture()
//        prepareUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSignUp"{
            let destinationVC = segue.destination as! SignupVC
        }/*else if segue.identifier == "toHomeVC"{*/
//            let destinationVC = segue.destination as! Home
//        }
    }
    
    private func prepareUI(){
        password.isSecureTextEntry = true
    }
    
    @IBAction func loginButton(_ sender: Any) {
        if !userName.text!.isEmpty && !password.text!.isEmpty{
            Auth.auth().signIn(withEmail: userName.text!, password: password.text!) { authDataResult, error in
                if error != nil {
                    self.showAlert(title: "Giriş başarısız", message: error!.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: "toHomeVC", sender: nil)
                    let userID = authDataResult?.user.uid
                    let db = Firestore.firestore()
                    let userRef = db.collection("UserRoles").document(userID!)

                    userRef.getDocument { (document, error) in
                        if let document = document, document.exists {
                            if let role = document.data()?["role"] as? String {
                                print("Kullanıcının rolü: \(role)")
                            } else {
                                print("Rol bulunamadı.")
                            }
                        } else {
                            print("Belge bulunamadı veya okuma hatası: \(error?.localizedDescription ?? "")")
                        }
                    }
                    print(userID ?? "boş geldi")
                    }
            }
        }else {
            showAlert(title: "Hata", message: "Kullanıcı adı ve şifre boş bırakılamaz.")
        }
    }
    
    private func gesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        signUpLabel.isUserInteractionEnabled = true
        signUpLabel.addGestureRecognizer(tapGesture)
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressImageView))
        isSecureTextIV.isUserInteractionEnabled = true
        isSecureTextIV.addGestureRecognizer(longPressGesture)
        
        let tapGestureKeyboard = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGestureKeyboard)
    }
    
//    private func showAlert(title:String, message:String){
//        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
//        let okButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.cancel)
//        
//        alert.addAction(okButton)
//        self.present(alert, animated: true)
//    }
    
    @objc func labelTapped() {
       performSegue(withIdentifier: "toSignUp", sender: nil)
    }
    
    @objc func longPressImageView(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            password.isSecureTextEntry = false
        }else{
            password.isSecureTextEntry = true
        }
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
        scroll.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
}


extension LoginVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scroll.setContentOffset(CGPoint(x: 0, y: 100), animated: true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       if textField == userName {
           password.becomeFirstResponder()
       } else {
           textField.resignFirstResponder()
           scroll.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
       }
       return true
    }
}
