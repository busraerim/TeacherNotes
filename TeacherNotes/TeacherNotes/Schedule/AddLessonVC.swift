//
//  AddLessonVC.swift
//  TeacherNotes
//
//  Created by Büşra Erim on 24.01.2024.
//

import UIKit

class AddLessonVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var numberofLesson:Int = 0 //dolu
    var lessonStartTime: String = ""
    var lessonEndTime: String = ""
    var className: String = ""
    var lessonName: String = ""
    var checkBox: UIImage?
    var titleHeader: [String] = []
    var selectedCell: Int?
    var day: String = "" //dolu
    var scheduleTime: [Schedule] = []
    var delegate: GetScheduleData?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        setupTableViewFooter()
    }
    
    private func prepareTableView(){
        tableView.register(AddLessonCell.nib(), forCellReuseIdentifier: AddLessonCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupTableViewFooter() {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        footer.backgroundColor = .clear
        tableView.tableFooterView = footer
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        header.backgroundColor = .clear
        tableView.tableHeaderView = header
        
        let saveButton = UIButton()
        configureSaveButton(saveButton, in: footer)
    }
    
    
    private func configureSaveButton(_ button: UIButton, in view: UIView) {
        button.backgroundColor = UIColor(red: 0.39, green: 0.22, blue: 0.26, alpha: 1.00)
        button.setTitle("Kaydet", for: .normal)
        button.setTitleColor(UIColor(red: 0.92, green: 0.89, blue: 0.82, alpha: 1.00)
                             , for: .normal)
        button.frame = CGRect(x: 50, y: 15 , width: view.frame.width - 100, height: 50)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc func saveButtonTapped(_ sender: Any) {
        //cellin içindeki verileri alıp scheduleTime a ekle.
        var allLessons = [Schedule]()
        
        for section in 0..<numberofLesson {
            guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: section)) as? AddLessonCell else {
                continue
            }
            
            let startTime = cell.startTim.text ?? ""
            let endTime = cell.endTime.text ?? ""
            let className = cell.className.text ?? ""
            let lessonName = cell.lessonName.text ?? ""
            
            if !cell.isSelectedCheckBox {
                let lesson = Schedule(day: day, time: "\(startTime) - \(endTime)", section: "\(section). ders", lesson: lessonName, className: className)
                allLessons.append(lesson)
            }else{
                let lesson = Schedule(day: day, time: "\(startTime) - \(endTime)", section: "\(section). ders", lesson: "Boş Ders", className: "-")
                allLessons.append(lesson)
            }
        }
        
        scheduleTime = allLessons
        self.view.window!.rootViewController?.dismiss(animated: true,
                                                      completion: { self.delegate?.getData(data: self.scheduleTime) })
    }
    
    
}


extension AddLessonVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberofLesson
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        for index in 1...numberofLesson{
            titleHeader.append("\(index). ders")
        }
        return titleHeader[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddLessonCell.identifier, for: indexPath) as! AddLessonCell
        return cell
    }
}

