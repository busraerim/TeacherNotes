//
//  AddNewVC.swift
//  TeacherNotes
//
//  Created by Büşra Erim on 11.01.2024.
//

import UIKit

class AddNewVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataTextField:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        prepareTableView()
        setupTableViewFooter()
    }
    
    private func prepareTableView(){
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "tableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupTableViewFooter() {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 80))
        footer.backgroundColor = .clear
        tableView.tableFooterView = footer
        
        let saveButton = UIButton()
        configureSaveButton(saveButton, in: footer)
    }
        
    private func configureSaveButton(_ button: UIButton, in view: UIView) {
        button.backgroundColor = UIColor(red: 0.23, green: 0.30, blue: 0.22, alpha: 1.00)
        button.frame = CGRect(x: (view.frame.width - 150) / 2, y: 15, width: 150, height: 50)
        button.layer.cornerRadius = 20
        button.setTitle("Kaydet", for: .normal)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc func saveButtonTapped(){
        dismiss(animated: true)
    }

}

extension AddNewVC: UITableViewDelegate {
    
}

extension AddNewVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        return cell
    }
    
    
}
