//
//  AddLessonVC.swift
//  TeacherNotes
//
//  Created by Büşra Erim on 24.01.2024.
//

import UIKit

class AddLessonVC: UIViewController {
    
    var numberofLesson:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func saveButtonTapped(_ sender: Any) {
        self.view.window!.rootViewController?.dismiss(animated: true)
    }
}
