//
//  NotesViewController.swift
//  AisleTechChallenge
//
//  Created by Shoumik on 07/11/24.
//

import UIKit

class NotesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.register(UINib(nibName: "NotesTableViewCell", bundle: nil), forCellReuseIdentifier: "NotesTableViewCell")
            tableView.showsVerticalScrollIndicator = false
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let modal = PhoneNumberViewController()
        modal.modalPresentationStyle = .overFullScreen
        self.present(modal, animated: false) { [weak self] in
            self?.view.isHidden = false
        }
    }
}

extension NotesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesTableViewCell", for: indexPath)
        return cell
    }
}
