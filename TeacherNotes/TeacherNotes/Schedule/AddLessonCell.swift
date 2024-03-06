//
//  AddLessonCell.swift
//  TeacherNotes
//
//  Created by BusraErim on 28.02.2024.
//

import UIKit

class AddLessonCell: UITableViewCell {
    
    @IBOutlet weak var startTim: UITextField!
    @IBOutlet weak var endTime: UITextField!
    @IBOutlet weak var className: UITextField!
    @IBOutlet weak var lessonName: UITextField!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var checkBox: UIButton!
    var pickerView = UIPickerView()
    var lessonData: Schedule?

    
    static let identifier = "AddLessonCell"
    var isSelectedCheckBox = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isSelectedCheckBox = false
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "AddLessonCell", bundle: nil)
    }
    
    private func preparePicker() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    
    @IBAction func selectedButton(_ sender: Any) {
        isSelectedCheckBox = !isSelectedCheckBox
        if isSelectedCheckBox == true {
            stackView.isHidden = true
            checkBox.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        } else {
            stackView.isHidden = false
            checkBox.setImage(UIImage(systemName: "square"), for: .normal)
        }
    }
    
}


extension AddLessonCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    
}
