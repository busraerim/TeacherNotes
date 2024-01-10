//
//  CollectionReusableView.swift
//  TeacherNotes
//
//  Created by Büşra Erim on 10.01.2024.
//

import UIKit

class CollectionReusableView: UICollectionReusableView {

    static let identifier = "CollectionReusableView"
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "CollectionReusableView", bundle: nil)
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//    }
//    
}
