//
//  DetailVC.swift
//  TeacherNotes
//
//  Created by Büşra Erim on 10.01.2024.
//

import UIKit

class DetailVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataImage = ["","","","",""]
    var dataTitle = ["1", "2", "3", "4"]

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        prepareCollectionView()
    }
    
    private func prepareCollectionView(){
        let layout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
        collectionView.register(CollectionViewCell.nib(), forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.register(CollectionReusableView.nib(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionReusableView.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }


}


extension DetailVC: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionView.deselectItem(at: indexPath, animated: true)
//        performSegue(withIdentifier: "toDetailVC", sender: nil)
//    }
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toDetilVC" {
//            let destinationVC = segue.destination as! DetailVC
//        }
//    }
}

extension DetailVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        let image = dataImage[indexPath.row]
        let title = dataTitle[indexPath.row]
        cell.configure(image: image, title: title)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionReusableView.identifier, for: indexPath)
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
