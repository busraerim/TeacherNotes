//
//  DetailCollectionReusableView.swift
//  TeacherNotes
//
//  Created by BusraErim on 1.03.2024.
//

import UIKit

class DetailCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    

    static let identifier = "DetailCollectionReusableView"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public func configure(title: String, image: String){
        titleLabel.text = title
        detailImage.image = UIImage(named: image)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "DetailCollectionReusableView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
//        fatalError()
        super.init(coder: coder)
    }
     
}
