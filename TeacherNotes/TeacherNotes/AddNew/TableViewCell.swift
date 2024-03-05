//
//  TableViewCell.swift
//  TeacherNotes
//
//  Created by Büşra Erim on 11.01.2024.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var textField: UITextField!

    let pickerView = UIPickerView()

    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
    }
    
    private func configureUI() {
        preparePicker()
        addToolBar()
    }
    
    private func preparePicker() {
        textField.inputView = pickerView
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    private func addToolBar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Tamam", style: UIBarButtonItem.Style.done, target: self, action: #selector(doneButtonTapped))
        toolBar.setItems([doneButton], animated: true)
        textField.inputAccessoryView = toolBar
    }
 
    @objc func doneButtonTapped() {
//        let selected = pickerView.selectedRow(inComponent: 0)
        textField.text = "deneme"
        textField.resignFirstResponder()
    }
    
}


extension TableViewCell : UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "Deneme"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = "Selected"
    }
}

extension TableViewCell : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    
    
}
