//
//  SignupVC.swift
//  TeacherNotes
//
//  Created by Büşra Erim on 8.01.2024.
//

import UIKit
import Firebase
import FirebaseFirestore

class SignupVC: UIViewController {
    
    @IBOutlet weak var nameSurnameTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    @IBOutlet weak var userTypeTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var passwordControl: UILabel!
    @IBOutlet weak var passwordConfirm: UILabel!
    @IBOutlet weak var signupButton: UIButton!
    
    let pickerView = UIPickerView()
    var userTypeData: [String] = ["Öğretmen", "Öğrenci", "Veli"]
    var userID = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        prepareTextFields()
        preparePicker()
        prepareLabel()
        addToolBar()
        addGestures()
    }
    
    private func prepareTextFields() {
        let textFields: [UITextField] = [nameSurnameTextField, mailTextField, passwordTextField, passwordConfirmTextField, userTypeTextField]
        
        textFields.enumerated().forEach({ index, textField in
            textField.delegate = self
            textField.tag = index + 1
        })
        
        userTypeTextField.inputView = pickerView
    }
    
    private func preparePicker(){
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    private func prepareLabel(){
        passwordControl.text = "Şifreniz en az 6 karakterden oluşmalıdır."
        passwordConfirm.text = "Şifreleriniz eşleşmiyor."
    }
//    
//    private func showAlert(title:String,message:String) {
//        let buttonOK = UIAlertAction(title: "Tamam", style: .cancel)
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alert.addAction(buttonOK)
//        self.present(alert, animated: true)
//    }
    
    private func addToolBar(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Tamam", style: UIBarButtonItem.Style.done, target: self, action: #selector(doneButtonTapped))
        toolBar.setItems([doneButton], animated: false)
        userTypeTextField.inputAccessoryView = toolBar
    }
    
    private func addGestures(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
          view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    @objc func doneButtonTapped(){
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        userTypeTextField.text = userTypeData[selectedRow]
        userTypeTextField.resignFirstResponder()
        scrollView.setContentOffset(CGPoint(x:0, y:0), animated: true)
    }
    
    @IBAction func signupButtonTapped(_ sender: Any) {
        let isBool = passwordTextField.text?.count ?? 0 < 6 || passwordConfirmTextField.text != passwordTextField.text || nameSurnameTextField.text?.count ?? 0 <= 0 || mailTextField.text?.count ?? 0 <= 0
        
        if isBool == true {
            showAlert(title: "Hata", message: "Lütfen ilgili alanları doldurunuz")
        } else {
            Auth.auth().createUser(withEmail: mailTextField.text!, password: passwordTextField.text!) { authDataResult, error in
                if error != nil {
                    self.showAlert(title: "Hata", message: error!.localizedDescription)
                }else{
                    self.userID = authDataResult!.user.uid
                    self.saveUserRoleToFirestore(userID: self.userID, role: self.userTypeTextField.text!, nameSurname: self.nameSurnameTextField.text!)
                    self.dismiss(animated: true)
                }
            }
        }
    }
    
    func saveUserRoleToFirestore(userID: String, role: String, nameSurname: String) {
        let db = Firestore.firestore()
        let userRef = db.collection("UserRoles").document(userID)
        
        userRef.setData(["role": role,"nameSurname": nameSurname]) { error in
            if let error = error {
                print("Firestore kaydı sırasında hata: \(error.localizedDescription)")
            } else {
                print("Firestore'a başarıyla kaydedildi.")
            }
        }
    }
    
}


extension SignupVC: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 100), animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let nextTextField = view.viewWithTag(textField.tag + 1) as? UITextField else {
            textField.resignFirstResponder()
            return true
        }
        nextTextField.becomeFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
          return textField != userTypeTextField
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField {
        case passwordTextField:
            passwordControl.isHidden = passwordTextField.text?.count ?? 0 >= 6
        case passwordConfirmTextField:
            passwordConfirm.isHidden = passwordConfirmTextField.text == passwordTextField.text
        default:
            break
        }
    }
}

extension SignupVC: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return userTypeData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return userTypeData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        userTypeTextField.text =  userTypeData[row]
    }
}
