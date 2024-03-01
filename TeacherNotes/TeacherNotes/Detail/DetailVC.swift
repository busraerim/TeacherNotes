//
//  DetailVC.swift
//  TeacherNotes
//
//  Created by Büşra Erim on 10.01.2024.
//

import UIKit


class DetailVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataImage: [String] = ["addNew"]
    var dataTitle: [String] = ["Yeni Ekle"]
    var detailTitle: String = ""
    var detailImage: String = ""
    var data: [String] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        prepareCollectionView()
    }
    
    internal func reloadData(){
        collectionView.reloadData()
    }
    
    private func prepareCollectionView(){
        let layout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 20)
        collectionView.register(CollectionViewCell.nib(), forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.register(DetailCollectionReusableView.nib(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetailCollectionReusableView.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }


}


extension DetailVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            collectionView.deselectItem(at: indexPath, animated: true)
            performSegue(withIdentifier: "toAddNewVC", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddNewVC" {
            let destinationVC = segue.destination as! AddNewVC
        }
    }
}

extension DetailVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        
        let image = dataImage[indexPath.row]
        let title = dataTitle[indexPath.row]
        
        if indexPath.row == 0 {
            cell.iconImageView.layer.borderWidth = 0
            cell.subtitleLabel.layer.borderWidth = 0
            cell.subtitleLabel.backgroundColor = .clear
        }
        
        cell.configure(image: image, title: title)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DetailCollectionReusableView.identifier, for: indexPath) as! DetailCollectionReusableView
//        header.configure(title: detailTitle, image: detailImage)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: view.frame.size.height/5)
    }
    
    
}

extension DetailVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 60) / 3, height: 150)
    }
}

