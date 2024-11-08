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
            heading.font = UIFont(name: "InterVariable-ExtraBold", size: 30)
            heading.text = "Enter Your \nPhone Number"
        }
    }
    
    @IBOutlet weak var subHeading: UILabel! {
        didSet {
            subHeading.font = UIFont(name: "InterVariable-Medium", size: 18)
        }
    }
    
    @IBOutlet weak var subHeadingIcon: UIImageView!
    
    @IBOutlet weak var countryCodeField: UITextField! {
        didSet {
            countryCodeField.font = UIFont(name: "InterVariable-Bold", size: 18)
            countryCodeField.textAlignment = .center
            countryCodeField.keyboardType = .phonePad
        }
    }
    
    @IBOutlet weak var phoneNumberField: UITextField! {
        didSet {
            phoneNumberField.font = UIFont(name: "InterVariable-Bold", size: 18)
            phoneNumberField.textAlignment = .center
            phoneNumberField.keyboardType = .phonePad
        }
    }
    
    @IBOutlet weak var otpField: UITextField! {
        didSet {
            otpField.font = UIFont(name: "InterVariable-Bold", size: 18)
        }
    }
    
    @IBOutlet weak var continueButton: UIButton! {
        didSet {
            continueButton.titleLabel?.font = UIFont(name: "InterVariable-Bold", size: 14)
        }
    }
    
    @IBOutlet weak var countdownText: UILabel! {
        didSet {
            countdownText.font = UIFont(name: "InterVariable-Bold", size: 14)
        }
    }
    
    @IBAction func clickedButton(_ sender: Any) {
        self.dismiss(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        countryCodeField.becomeFirstResponder()
    }
}
