//
//  PhoneNumberViewController.swift
//  AisleTechChallenge
//
//  Created by Shoumik on 07/11/24.
//

import UIKit

class PhoneNumberViewController: UIViewController {
    
    @IBOutlet weak var heading: UILabel! {
        didSet {
            heading.font = UIFont(name: "InterVariable-Medium", size: 30)
        }
    }
    
    @IBOutlet weak var subHeading: UILabel! {
        didSet {
            heading.font = UIFont(name: "InterVariable-Medium", size: 18)
        }
    }
    
    @IBOutlet weak var subHeadingIcon: UIImageView!
    
    @IBOutlet weak var countryCodeField: UITextField! {
        didSet {
            countryCodeField.font = UIFont(name: "InterVariable-Medium", size: 18)
        }
    }
    
    @IBOutlet weak var phoneNumberField: UITextField! {
        didSet {
            countryCodeField.font = UIFont(name: "InterVariable-Medium", size: 18)
        }
    }
    
    @IBOutlet weak var continueButton: UIButton! {
        didSet {
            continueButton.titleLabel?.font = UIFont(name: "InterVariable-Medium", size: 14)
        }
    }
    
    @IBOutlet weak var countdownText: UILabel! {
        didSet {
            countdownText.font = UIFont(name: "InterVariable-Medium", size: 14)
        }
    }
    
    @IBAction func clickedButton(_ sender: Any) {
        self.dismiss(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
