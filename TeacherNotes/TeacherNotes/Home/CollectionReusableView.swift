//
//  CollectionReusableView.swift
//  TeacherNotes
//
//  Created by Büşra Erim on 10.01.2024.
//

import UIKit

class CollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usertTypeLabel: UILabel!
    

    static let identifier = "CollectionReusableView"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    
    }
    
    public func configure(userRole: String, nameSurname:String){
        usertTypeLabel.text = userRole
        nameLabel.text = nameSurname
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "CollectionReusableView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
//        fatalError()
        super.init(coder: coder)
    }
     
}
