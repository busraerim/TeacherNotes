//
//  AddLessonCell.swift
//  TeacherNotes
//
//  Created by BusraErim on 28.02.2024.
//

import UIKit

protocol AddLessonCellRowHeightDelegate {
    func lessonData()
}

class AddLessonCell: UITableViewCell {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var checkBox: UIButton!
    var pickerView = UIPickerView()
    
    
    static let identifier = "AddLessonCell"
    var isSelectedCheckBox = false
    var delegate: AddLessonCellRowHeightDelegate?
    
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
                   delegate?.lessonData()
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
