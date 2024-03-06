//
//  AddScheduleVC.swift
//  TeacherNotes
//
//  Created by Büşra Erim on 17.01.2024.
//

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
    @IBOutlet weak var selectDay: UILabel!
    
    var delegate: GetScheduleData?
    var checkBoxArray:[UIImageView] = []
    var selectedDay:String = ""
    var days = ["Pazartesi", "Salı", "Çarşamba", "Perşembe", "Cuma", "Cumartesi", "Pazar"]
    var pickerView = UIPickerView()
    var lessonArray:[Int] = []
    var numberofLesson: Int = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addToolBar()
        createLabel()
    }
    
    private func configureUI(){
        prepareCheckBox()
        preparePicker()
    }

    private func createLabel(){
        let selectDaytext = "Gün seçiniz."
        let textRange = NSRange(location: 0, length: selectDaytext.count)
        let attiributedText = NSMutableAttributedString(string: selectDaytext)
        attiributedText.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: textRange)
        selectDay.attributedText = attiributedText
    }
    
    private func prepareCheckBox(){
        checkBoxArray = [mondayCheckBox, tuesdayCheckBox, wednesdayCheckBox, thursdayCheckBox, fridayCheckBox, saturdayCheckBox, sundayCheckBox]
        checkBoxArray.forEach({imageView in
            addTapGesture(to: imageView)
        })
        days.enumerated().forEach({index, day in
            if days[index] == selectedDay{
                let selectedCheckBox = checkBoxArray[index]
                selectedCheckBox.image = UIImage(systemName: "checkmark.square")
                selectedCheckBox.tintColor = UIColor(red: 0.23, green: 0.30, blue: 0.22, alpha: 1.00)
            }
        })
    }
    
    private func preparePicker() {
        for index in 1...20 {
            self.lessonArray.append(index)
        }
        numberOfLessonTextField.inputView = pickerView
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    private func addToolBar(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Tamam", style: UIBarButtonItem.Style.done, target: self, action: #selector(doneButtonTapped))
        toolBar.setItems([doneButton], animated: false)
        numberOfLessonTextField.inputAccessoryView = toolBar
    }
    
    @objc func doneButtonTapped(){
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        numberOfLessonTextField.text = String(lessonArray[selectedRow])
        numberOfLessonTextField.resignFirstResponder()
        scrollView.setContentOffset(CGPoint(x:0, y:0), animated: true)
    }
    
    
    private func addTapGesture(to imageView: UIImageView) {
       let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectedCheck))
       imageView.isUserInteractionEnabled = true
       imageView.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        if numberOfLessonTextField.text!.count <= 0 {
           showAlert(title: "Hata", message: "İlgili alanları doldurunuz.")
        }else {
            for index in lessonArray {
                if numberOfLessonTextField.text == String(index){
                  self.numberofLesson = index
                }
            }
            performSegue(withIdentifier: "toAddLessonVC", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! AddLessonVC
        destinationVC.delegate = delegate
        destinationVC.numberofLesson = numberofLesson
        destinationVC.day = selectedDay
    }
    
    @objc func selectedCheck(_ sender: UITapGestureRecognizer){
        let selectedCheckBox = sender.view
        checkBoxArray.enumerated().forEach({index, imageView in
            if selectedCheckBox == imageView {
                imageView.image = UIImage(systemName: "checkmark.square")
                selectedDay = days[index]
            }else {
                imageView.image = UIImage(systemName: "square")
            }
            imageView.tintColor = UIColor(red: 0.23, green: 0.30, blue: 0.22, alpha: 1.00)
        })
    }

}


extension AddScheduleVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return lessonArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(lessonArray[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        numberOfLessonTextField.text =  String(lessonArray[row])
    }
}


