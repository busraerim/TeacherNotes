//
//  ScheduleVC.swift
//  TeacherNotes
//
//  Created by Büşra Erim on 16.01.2024.
//

import UIKit

protocol GetScheduleData{
    func getData(startTime:String, endTime:String, section:String, lesson:String, className:String)
}

class ScheduleVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var daySegment: UISegmentedControl!
    
    var scheduleTime: [Schedule] = []
    var inputData: GetDataSchedule?
    var section : String?
    var lesson : String?
    var className: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        prepareTableView()
        setupTableViewFooter()
    }
    
    private func prepareTableView(){
        let nib = UINib(nibName: "ScheduleTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "scheduleTableViewCell")
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
        button.backgroundColor = UIColor(red: 0.23, green: 0.30, blue: 0.22, alpha: 1.00)
        button.setTitle("Ders Ekle", for: .normal)
        button.frame = CGRect(x: (view.frame.width - 150) / 2, y: 15, width: 150, height: 50)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc func saveButtonTapped(){
        performSegue(withIdentifier: "toAddScheduleVC", sender: nil)
        switch daySegment.selectedSegmentIndex {
        case 0:
            var day = "Pazartesi"
        case 1:
            var day = "Salı"
        case 2:
            var day = "Çarşamba"
        case 3:
            var day = "Perşembe"
        case 4:
            var day = "Cuma"
        case 5:
            var day = "Cumartesi"
        case 6:
            var day = "Pazar"
        default:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddScheduleVC" {
            let destinationVC = segue.destination as! AddScheduleVC
            destinationVC.delegate = self
            
        }
    }
}

extension ScheduleVC: UITableViewDelegate {
    
}

extension ScheduleVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleTime.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleTableViewCell", for: indexPath) as! ScheduleTableViewCell
        cell.configure(time: scheduleTime[indexPath.row].time, section: scheduleTime[indexPath.row].section, className: scheduleTime[indexPath.row].className)
        return cell
    }
    
}

extension ScheduleVC: GetScheduleData{
    func getData(startTime:String, endTime:String, section:String, lesson:String, className:String){
        let time = "\(startTime)-\(endTime)"
        let section = section
        let lessonName = lesson
        let className = className
        scheduleTime.append(Schedule(day: "", time: time, section: section, lesson: lessonName, className: className))
        tableView.reloadData()
    }
    
    
}

