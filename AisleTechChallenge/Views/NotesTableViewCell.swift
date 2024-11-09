//
//  NotesTableViewCell.swift
//  AisleTechChallenge
//
//  Created by Shoumik on 08/11/24.
//

import UIKit

class NotesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel! {
        didSet {
            title.font = UIFont(name: "Gilroy-ExtraBold", size: 27)
        }
    }
    @IBOutlet weak var subtitle: UILabel! {
        didSet {
            subtitle.font = UIFont(name: "Gilroy-SemiBold", size: 18)
        }
    }
    
    @IBOutlet weak var inviteImage: UIImageView! {
        didSet {
            inviteImage.layer.cornerRadius = 15
            inviteImage.image = UIImage(systemName: "network")
            inviteImage.tintColor = .gray
        }
    }
    @IBOutlet weak var inviteTitle: UILabel! {
        didSet {
            inviteTitle.font = UIFont(name: "Gilroy-ExtraBold", size: 22)
            inviteTitle.textColor = .white
            inviteTitle.isHidden = true
        }
    }
    @IBOutlet weak var inviteSubtitle: UILabel! {
        didSet {
            inviteSubtitle.text = "Tap to review your notes"
            inviteSubtitle.font = UIFont(name: "Gilroy-SemiBold", size: 15)
            inviteSubtitle.textColor = .white
            inviteSubtitle.isHidden = true
        }
    }
    
    @IBOutlet weak var upgradeTitle: UILabel! {
        didSet {
            upgradeTitle.font = UIFont(name: "Gilroy-ExtraBold", size: 22)
        }
    }
    @IBOutlet weak var upgradeDescription: UILabel! {
        didSet {
            upgradeDescription.font = UIFont(name: "Gilroy-SemiBold", size: 15)
            
        }
    }
    @IBOutlet weak var upgradeButton: UIButton!
    
    @IBOutlet weak var firstLikeImage: UIImageView! {
        didSet {
            firstLikeImage.layer.cornerRadius = 10
            firstLikeImage.image = UIImage(systemName: "network")
            firstLikeImage.tintColor = .gray
        }
    }
    @IBOutlet weak var firstLikeTitlte: UILabel! {
        didSet {
            firstLikeTitlte.font = UIFont(name: "Gilroy-ExtraBold", size: 18)
            firstLikeTitlte.textColor = .white
        }
    }
    
    @IBOutlet weak var secondLikeImage: UIImageView! {
        didSet {
            secondLikeImage.layer.cornerRadius = 10
            secondLikeImage.image = UIImage(systemName: "network")
            secondLikeImage.tintColor = .gray
        }
    }
    @IBOutlet weak var secondLikeTitle: UILabel! {
        didSet {
            secondLikeTitle.font = UIFont(name: "Gilroy-ExtraBold", size: 18)
            secondLikeTitle.textColor = .white
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadWithData(viewModel: NotesViewModel) {
        if !viewModel.invites.isEmpty {
            inviteTitle.text = (viewModel.invites.first?.name ?? "") + ", " + (viewModel.invites.first?.dob?.ageFromDob ?? "")
            
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                let request = URLRequest(url: URL(string: viewModel.invites.first?.imageURL ?? "anyurl.com")!)
                let _ = URLSession.shared.dataTask(with: request) { data, _, error in
                    guard error == nil else { return }
                    if let data, !data.isEmpty {
                        DispatchQueue.main.async { [weak self] in
                            guard let self else { return }
                            inviteImage.image = UIImage(data: data)
                            inviteTitle.isHidden = false
                            inviteSubtitle.isHidden = false
                        }
                    }
                }.resume()
            }
        }
        
        if !viewModel.likes.isEmpty {
            firstLikeTitlte.text = viewModel.likes.first?.name
            secondLikeTitle.text = viewModel.likes.last?.name
            
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                let firstRequest = URLRequest(url: URL(string: viewModel.likes.first?.imageURL ?? "anyurl.com")!)
                let _ = URLSession.shared.dataTask(with: firstRequest) { data, _, error in
                    guard error == nil else { return }
                    if let data, !data.isEmpty {
                        DispatchQueue.main.async { [weak self] in
                            guard let self else { return }
                            firstLikeImage.image = UIImage(data: data)
                            let blurEffect = UIBlurEffect(style: .dark)
                            let blurredEffectView = UIVisualEffectView(effect: blurEffect)
                            blurredEffectView.frame = firstLikeImage.bounds
                            blurredEffectView.layer.cornerRadius = 10
                            firstLikeImage.addSubview(blurredEffectView)
                        }
                    }
                }.resume()
                
                let secondRequest = URLRequest(url: URL(string: viewModel.likes.last?.imageURL ?? "anyurl.com")!)
                let _ = URLSession.shared.dataTask(with: secondRequest) { data, _, error in
                    guard error == nil else { return }
                    if let data, !data.isEmpty {
                        DispatchQueue.main.async { [weak self] in
                            guard let self else { return }
                            secondLikeImage.image = UIImage(data: data)
                            let blurEffect = UIBlurEffect(style: .dark)
                            let blurredEffectView = UIVisualEffectView(effect: blurEffect)
                            blurredEffectView.frame = secondLikeImage.bounds
                            blurredEffectView.layer.cornerRadius = 10
                            secondLikeImage.addSubview(blurredEffectView)
                        }
                    }
                }.resume()
            }
        }
    }
    
}
