//
//  ViewController.swift
//  TeacherNotes
//
//  Created by Büşra Erim on 8.01.2024.
//

import UIKit

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
        prepareUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSignUp"{
            let destinationVC = segue.destination as! SignupVC
        }
    }
    
    private func prepareUI(){
        password.isSecureTextEntry = true
    }
    
    @IBAction func loginButton(_ sender: Any) {
    }
    
    private func gesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        signUpLabel.isUserInteractionEnabled = true
        signUpLabel.addGestureRecognizer(tapGesture)
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressImageView))
        isSecureTextIV.isUserInteractionEnabled = true
        isSecureTextIV.addGestureRecognizer(longPressGesture)
    }
    
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
