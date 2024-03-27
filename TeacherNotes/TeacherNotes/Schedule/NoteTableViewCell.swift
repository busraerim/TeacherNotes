//
//  NoteTableViewCell.swift
//  TeacherNotes
//
//  Created by Büşra Erim on 21.03.2024.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    static let identifier = "NoteTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "NoteTableViewCell", bundle: nil)
    }
    
    public func createLabel(note:String){
        let note = note
    }
}
