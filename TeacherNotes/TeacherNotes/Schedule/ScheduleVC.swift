//
//  ScheduleVC.swift
//  TeacherNotes
//
//  Created by Büşra Erim on 16.01.2024.
//

import UIKit
import TinyConstraints
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import Kingfisher


class ScheduleVC: UIViewController {
    
    @IBOutlet weak var scheduleIV: UIImageView!
    @IBOutlet weak var expandableStackView: UIStackView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var buttonsStackView: UIStackView!
    @IBOutlet weak var noteTableView: UITableView!
    @IBOutlet weak var expandableButton: UIButton!
    
    var notes: [[String:String]] = []
    let emptyNote = "Not yok"
    var expanded: Bool = true
    var textViewExpanded: Bool = true
    
    let firestoreDatabase = Firestore.firestore()
    let userID = Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = VCTitles.ScheduleVc.rawValue
        configureUI()
        getData()
        configureTableView()
    }
    
    private func configureUI(){
        self.expandableStackView.arrangedSubviews[1].isHidden = expanded
        self.expandableStackView.arrangedSubviews[2].isHidden = expanded
        self.expandableStackView.arrangedSubviews[3].isHidden = expanded
        self.buttonsStackView.arrangedSubviews[1].isHidden = textViewExpanded
        expandableButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
    }
    
    private func configureTableView(){
        noteTableView.register(NoteTableViewCell.nib(), forCellReuseIdentifier: NoteTableViewCell.identifier)
    }
    
    private func getData(){
        firestoreDatabase.collection("UserRoles").document(self.userID!).getDocument(){(document,error) in
            if error != nil {
                self.showAlert(title: "Hata", message: error!.localizedDescription)
            }else{
                guard let scheduleImageURL = document?.data()?["imageURL"] as? String else {return self.scheduleIV.image = UIImage(named: "noSchedule")}
                let url = URL(string: scheduleImageURL)
                self.scheduleIV.kf.setImage(with: url)
            }
        }
    }
    
    @IBAction func tappedButton(_ sender: Any) {
        expanded = !expanded
        self.expandableStackView.arrangedSubviews[1].isHidden = self.expanded
        if expandableButton.currentImage == UIImage(systemName: "chevron.down"){
            expandableButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        }else{
            expandableButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        }
    }
    
    @IBAction func uploadButtonTapped(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func takePhotoTapped(_ sender: Any) {
    }
    
    @IBAction func addNewNoteButton(_ sender: Any) {
        textViewExpanded = !textViewExpanded
        self.expandableStackView.arrangedSubviews[2].isHidden = textViewExpanded
        self.buttonsStackView.arrangedSubviews[1].isHidden = textViewExpanded
    }
    
    @IBAction func saveNoteButton(_ sender: Any) {
        if textView.text.isEmpty {
            showAlert(title: "Hata", message: "İlgili alanları doldurunuz.")
        }else{
            let index = notes.count
            let note = textView.text
            notes.append(["\(index+1). not":"note"])
        }
        
    }
}

extension ScheduleVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            uploadImageToFirebase(image: pickedImage)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func uploadImageToFirebase(image: UIImage) {
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let scheduleFolder = storageReference.child("scheduleFolder")
        
        if let data = image.jpegData(compressionQuality: 0.5) {
            let uuid = UUID().uuidString
            let imageReference = scheduleFolder.child("\(uuid).jpeg")
            imageReference.putData(data, metadata: nil) { (metadata, error) in
                if error != nil {
                    self.showAlert(title: "Hata", message: error?.localizedDescription ?? "Fotoğraf Yüklenemedi.")
                } else {
                    imageReference.downloadURL { (url, error) in
                        if error == nil{
                            let imageURL = url?.absoluteString
                            if let imageURL = imageURL {
                                let param = ["imageURL": imageURL] as [String:Any]
                                self.firestoreDatabase.collection("UserRoles").document(self.userID!).setData(param, merge: true) {error in
                                    if let error = error {
                                        self.showAlert(title: "Hata", message: error.localizedDescription)
                                    }else{
                                        self.firestoreDatabase.collection("UserRoles").document(self.userID!).getDocument(){document, error in
                                            if error != nil {
                                                self.showAlert(title: "Hata", message: error!.localizedDescription)
                                            }else if let document = document, document.exists, let scheduleImageURL = document.get("imageURL") as? String{
                                                let url = URL(string: scheduleImageURL)
                                                self.scheduleIV.kf.setImage(with: url)
                                            }else{
                                                print("Document does not exist")
                                            }
                                        }
                                    }
                                }
                            }
                        } else {
                            self.showAlert(title: "Hata", message: error?.localizedDescription ?? "Fotoğraf Yüklenemedi.")
                        }
                        
                    }
                }
            }
        }
    }
}
