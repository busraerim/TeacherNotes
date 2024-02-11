//
//  AddScheduleVC.swift
//  TeacherNotes
//
//  Created by Büşra Erim on 17.01.2024.
//

/*
 Sayfaya scroll eklenecek.
 Eğer herhangi bir gün işaretlenmediyse ya da ders sayısı 0dan küçük girildiyse show alert
 */

import UIKit

class AddScheduleVC: UIViewController {

   
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mondayCheckBox: UIImageView!
    @IBOutlet weak var tuesdayCheckBox: UIImageView!
    @IBOutlet weak var wednesdayCheckBox: UIImageView!
    @IBOutlet weak var thursdayCheckBox: UIImageView!
    @IBOutlet weak var fridayCheckBox: UIImageView!
    @IBOutlet weak var saturdayCheckBox: UIImageView!
    @IBOutlet weak var sundayCheckBox: UIImageView!
    @IBOutlet weak var numberOfLessonTextField: UITextField!
    
    var delegate: GetScheduleData?
    var checkBoxArray:[UIImageView] = []
    var selectedDay:String = ""
    var days = ["Pazartesi", "Salı", "Çarşamba", "Perşembe", "Cuma", "Cumartesi", "Pazar"]
    var isSelected = false

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI(){
        prepareCheckBox()
    }
    
    private func prepareCheckBox(){
        checkBoxArray = [mondayCheckBox, tuesdayCheckBox, wednesdayCheckBox, thursdayCheckBox, fridayCheckBox, saturdayCheckBox, sundayCheckBox]
        checkBoxArray.forEach({imageView in
            addTapGesture(to: imageView)
        })
    }
    
    private func addTapGesture(to imageView: UIImageView) {
       let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectedCheck))
       imageView.isUserInteractionEnabled = true
       imageView.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        if numberOfLessonTextField.text!.count <= 0 || isSelected == false{
           showAlert(title: "Hata", message: "İlgili alanları doldurunuz.")
        }else {
            performSegue(withIdentifier: "toAddLessonVC", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! AddLessonVC
        destinationVC.numberofLesson = numberOfLessonTextField.text!
    }
    
    @objc func selectedCheck(_ sender: UITapGestureRecognizer){
        let selectedCheckBox = sender.view
        checkBoxArray.enumerated().forEach({index, imageView in
            if selectedCheckBox == imageView {
                imageView.image = UIImage(systemName: "checkmark.square")
                selectedDay = days[index]
                isSelected = true
            }else {
                imageView.image = UIImage(systemName: "square")
            }
            imageView.tintColor = UIColor(red: 0.23, green: 0.30, blue: 0.22, alpha: 1.00)
        })
    }

}
