//
//  AddNewClassVC.swift
//  TeacherNotes
//
//  Created by BusraErim on 5.03.2024.
//

import UIKit

class AddNewClassVC: UIViewController {
    
    @IBOutlet weak var classDegree: UITextField!
    @IBOutlet weak var className: UITextField!
    
    var pickerView = UIPickerView()
    var classArray: [Int] = []
    var classID = ""
    var classData: [String] = []
 
    var delegate: ReloadDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preparePicker()
        addToolBar()

    }
    
    private func preparePicker() {
        for index in 1...12 {
            self.classArray.append(index)
        }
        classDegree.inputView = pickerView
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    private func addToolBar(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Tamam", style: UIBarButtonItem.Style.done, target: self, action: #selector(doneButtonTapped))
        toolBar.setItems([doneButton], animated: false)
        classDegree.inputAccessoryView = toolBar
    }
    
    @objc func doneButtonTapped(){
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        classDegree.text = String(classArray[selectedRow])
        classDegree.resignFirstResponder()
    }
    
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        if classDegree.text?.isEmpty == true || className.text?.isEmpty == true{
            showAlert(title: "Hata", message: "Lütfen ilgili alanları doldurunuz.")
        }else{
            classData.append(classDegree.text! + "-" + className.text!)
            self.dismiss(animated: true, completion: ({self.delegate?.classreloadData(data: self.classData)}))
        }
    }
    

}


extension AddNewClassVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return classArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(classArray[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        classDegree.text =  String(classArray[row])
    }
}


