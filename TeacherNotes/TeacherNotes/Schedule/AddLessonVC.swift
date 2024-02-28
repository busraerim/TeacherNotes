//
//  AddLessonVC.swift
//  TeacherNotes
//
//  Created by Büşra Erim on 24.01.2024.
//

import UIKit

class AddLessonVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var numberofLesson:Int = 0
    var lessonStartTime: Date?
    var lessonEndTime: Date?
    var className: String = ""
    var lessonName: String = ""
    var checkBox: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        print(numberofLesson)
    }
    
    private func prepareTableView(){
        tableView.register(AddLessonCell.nib(), forCellReuseIdentifier: AddLessonCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        self.view.window!.rootViewController?.dismiss(animated: true)
    }
}


extension AddLessonVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberofLesson
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}
