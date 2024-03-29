//
//  DetailVC.swift
//  TeacherNotes
//
//  Created by Büşra Erim on 10.01.2024.
//

import UIKit
import Firebase
import FirebaseFirestore

protocol ReloadDataDelegate {
    func classreloadData(data: [String])
}


class DetailVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let db = Firestore.firestore()
    
    var dataImage: [String] = ["addNew"]
    var dataTitle: [String] = ["Yeni Ekle"]
    var detailTitle: String = ""
    var detailImage: String = ""
    var data: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = detailTitle
    }
    
    private func configureUI() {
        prepareCollectionView()
    }
    
    private func prepareCollectionView(){
        let layout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 20)
        collectionView.register(CollectionViewCell.nib(), forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
//    
//    private func getDataClass(){
//        let userRef = db.collection("Classes").document()
//        
//        userRef.getDocument { (document, error) in
//            if error != nil {
//                print(error!.localizedDescription)
//            }else{
//                guard let className = document?.data()?["className"] as? String else { return print("Not found Class")}
//                
//                
//            }
//        }
//    }
    
}


extension DetailVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if detailTitle == "Sınıflar" {
                performSegue(withIdentifier: StoryboardNames.toAddNewClassVC.rawValue, sender: nil)
            }else{
                collectionView.deselectItem(at: indexPath, animated: true)
                performSegue(withIdentifier: "toAddNewVC", sender: nil)
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddNewVC" {
            let destinationVC = segue.destination as! AddNewVC
        }else if segue.identifier == StoryboardNames.toAddNewClassVC.rawValue {
            let destinationVC = segue.destination as! AddNewClassVC
            destinationVC.sheetPresentationController?.detents = [.medium()]
            destinationVC.sheetPresentationController?.prefersGrabberVisible = true
            destinationVC.delegate = self
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
        }else {
            cell.iconImageView.layer.borderWidth = 0.5
            cell.subtitleLabel.layer.borderWidth = 0.5
            cell.subtitleLabel.backgroundColor = UIColor(named: "TextFields")
        }
        
        cell.configure(image: image, title: title)
        return cell
    }
}

extension DetailVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 60) / 3, height: 150)
    }
}


extension DetailVC: ReloadDataDelegate {
    func classreloadData(data: [String]) {
        for className in data{
            dataTitle.append(className)
            dataImage.append(detailImage)
        }
        collectionView.reloadData()
    }
}
