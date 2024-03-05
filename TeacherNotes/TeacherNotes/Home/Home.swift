//
//  Home.swift
//  TeacherNotes
//
//  Created by Büşra Erim on 10.01.2024.
//

import UIKit
import Firebase
import FirebaseFirestore

class Home: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var nameLabel:String = ""
    var userRole:String = ""
    var menu:[homePage] = []
    var detailTitle: String = ""
    var detailImage: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func configureUI() {
        prepareCollectionView()
        getData()
    }
    
    private func prepareCollectionView(){
        let layout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 40, left: 20, bottom: 0, right: 20)
        collectionView.register(CollectionViewCell.nib(), forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.register(CollectionReusableView.nib(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionReusableView.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func getData(){
        let userID = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()
        let userRef = db.collection("UserRoles").document(userID!)
        
        userRef.getDocument { (document, error) in
            if error != nil {
                print(error!.localizedDescription)
            }else{
                guard let role = document?.data()?["role"] as? String else {return print("negative role")}
                guard let nameSurname = document?.data()?["nameSurname"] as? String else {return print("negative")}
                
                self.nameLabel = nameSurname
                self.userRole = role
                switch self.userRole{
                case UserRoles.teacher.rawValue:
                    self.menu = UserRoles.teacher.homePages
                case UserRoles.student.rawValue:
                    self.menu = UserRoles.student.homePages
                case UserRoles.parent.rawValue:
                    self.menu = UserRoles.parent.homePages
                default:
                    break
                }
                self.collectionView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toScheduleVC" {
            let destinationVC = segue.destination as! ScheduleVC
        }else if segue.identifier == "toDetailVC" {
            let destinationVC = segue.destination as! DetailVC
            destinationVC.detailTitle = self.detailTitle
            destinationVC.detailImage = self.detailImage
        }
    }
}

extension Home: UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if indexPath.row == 0 {
            performSegue(withIdentifier: "toScheduleVC", sender: nil)
        }else if indexPath.row == 1 || indexPath.row == 2{
            self.detailTitle = menu[indexPath.row].title
            self.detailImage = menu[indexPath.row].image
            performSegue(withIdentifier: "toDetailVC", sender: nil)
        }else{
            
        }
    }
}

extension Home: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menu.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        let image = menu[indexPath.row].image
        let title = menu[indexPath.row].title
        cell.configure(image: image, title: title)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionReusableView.identifier, for: indexPath) as! CollectionReusableView
        header.configure(userRole: userRole, nameSurname: nameLabel)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: view.frame.size.height/5)
    }
}

extension Home: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 60) / 3, height: 150)
    }
}

