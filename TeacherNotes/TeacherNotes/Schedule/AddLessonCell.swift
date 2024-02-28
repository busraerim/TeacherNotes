//
//  AddLessonCell.swift
//  TeacherNotes
//
//  Created by BusraErim on 28.02.2024.
//

import UIKit

class AddLessonCell: UITableViewCell {

    static let identifier = "AddLessonCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    static func nib() -> UINib {
        return UINib(nibName: "AddLessonCell", bundle: nil)
    }
    
}
