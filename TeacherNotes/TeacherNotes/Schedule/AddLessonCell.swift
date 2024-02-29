//
//  AddLessonCell.swift
//  TeacherNotes
//
//  Created by BusraErim on 28.02.2024.
//

import UIKit

protocol AddLessonCellRowHeightDelegate {
    func addLessonRowHeight(section: Int)
}

class AddLessonCell: UITableViewCell {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var checkBox: UIImageView!
    
    
    static let identifier = "AddLessonCell"
    var isSelectedCheckBox = false
    var delegate: AddLessonCellRowHeightDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addTapGesture()
        getIndexPathForThisCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "AddLessonCell", bundle: nil)
    }
    
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectedCheck))
        checkBox.isUserInteractionEnabled = true
        checkBox.addGestureRecognizer(tapGesture)
    }
    
    private func getIndexPathForThisCell() -> IndexPath? {
        if let tableView = superview as? UITableView {
            return tableView.indexPath(for: self)
        }
        return nil
    }
    
    @objc func selectedCheck(){
        delegate?.addLessonRowHeight(section: getIndexPathForThisCell()!.section)
//        isSelectedCheckBox = !isSelectedCheckBox
//        if isSelectedCheckBox == true {
//            
//            checkBox.image = UIImage(systemName: "checkmark.square")
//            stackView.isHidden = true
//            delegate?.addLessonRowHeight()
//        } else {
//            checkBox.image = UIImage(systemName: "square")
//            stackView.isHidden = false
//        }
    }

    
}


