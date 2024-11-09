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
    
    private var viewModel: NotesViewModel
    private var loginScreenPresented = false
    
    init(viewModel: NotesViewModel = NotesViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: "NotesViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !loginScreenPresented {
            let modal = PhoneNumberViewController(delegate: self)
            modal.modalPresentationStyle = .overFullScreen
            self.present(modal, animated: false) { [weak self] in
                guard let self else { return }
                view.isHidden = false
                loginScreenPresented = true
            }
        }
    }
}

extension NotesViewController: LoginScreenDelegateProtocol {
    func loadNotesScreen(with notesViewModel: NotesViewModel) {
        viewModel = notesViewModel
        tableView.reloadData()
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NotesTableViewCell", for: indexPath) as? NotesTableViewCell else { return UITableViewCell()}
        cell.loadWithData(viewModel: viewModel)
        return cell
    }
}
