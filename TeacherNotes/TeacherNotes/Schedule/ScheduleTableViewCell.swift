//
//  ScheduleTableViewCell.swift
//  TeacherNotes
//
//  Created by Büşra Erim on 17.01.2024.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var classNameLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    public func configure(time:String, section:String, className: String){
        timeLabel.text = time
        sectionLabel.text = section
        classNameLabel.text = className
    }
    
    
    
    
    
    
}
