//
//  CollectionViewCell.swift
//  TeacherNotes
//
//  Created by Büşra Erim on 10.01.2024.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    static let identifier = "CollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(image: String, title:String){
        iconImageView.image = UIImage(named: image)
        subtitleLabel.text = title
    }

    static func nib() -> UINib {
        return UINib(nibName: "CollectionViewCell", bundle: nil)
    }
}
