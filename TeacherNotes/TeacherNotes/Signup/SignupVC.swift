//
//  SignupVC.swift
//  TeacherNotes
//
//  Created by Büşra Erim on 8.01.2024.
//

import UIKit

class SignupVC: UIViewController {
    
    @IBOutlet weak var nameSurnameTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    @IBOutlet weak var userTypeTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var passwordControl: UILabel!
    @IBOutlet weak var passwordConfirm: UILabel!
    @IBOutlet weak var usernameMessage: UILabel!
    @IBOutlet weak var signupButton: UIButton!
    
    let pickerView = UIPickerView()
    var userTypeData: [String] = ["Öğretmen", "Öğrenci", "Veli"]
    
    var usernameMessageBool = false
    var passwordControlBool = false
    var passwordConfirmBool = false

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
        let textFields: [UITextField] = [nameSurnameTextField, mailTextField, usernameTextField, passwordTextField, passwordConfirmTextField, userTypeTextField]
        textFields.forEach {
            $0.delegate = self
        }
        
        userTypeTextField.inputView = pickerView
    }
    
    private func preparePicker(){
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    private func prepareLabel(){
        usernameMessage.text = "Kullanıcı adınız en az 3 karakterden oluşmalıdır."
        passwordControl.text = "Şifreniz en az 6 karakterden oluşmalıdır."
        passwordConfirm.text = "Şifreleriniz eşleşmiyor."
    }
    
    private func showAlert(title:String,message:String) {
        let buttonOK = UIAlertAction(title: "Tamam", style: .cancel)
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(buttonOK)
        self.present(alert, animated: true)
    }
    
    private func addToolBar(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([doneButton], animated: false)
        userTypeTextField.inputAccessoryView = toolbar
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
    }
    @IBAction func signupButtonTapped(_ sender: Any) {
        let requiredFieldsFilled = !usernameMessageBool && !passwordControlBool && !passwordConfirmBool &&
            !nameSurnameTextField.text!.isEmpty && !mailTextField.text!.isEmpty && !userTypeTextField.text!.isEmpty
        
        if !requiredFieldsFilled {
            showAlert(title: "Hata", message: "Lütfen ilgili alanları doldurunuz.")
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

    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField {
        case usernameTextField:
            usernameMessage.isHidden = usernameTextField.text?.count ?? 0 >= 4
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
