//
//  PhoneNumberViewController.swift
//  AisleTechChallenge
//
//  Created by Shoumik on 07/11/24.
//

import UIKit

protocol LoginScreenDelegateProtocol: AnyObject {
    func loadNotesScreen(with: NotesViewModel)
}

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
    
    @IBOutlet weak var countryCodeView: UIView!
    @IBOutlet weak var countryCodeField: UITextField! {
        didSet {
            countryCodeField.font = UIFont(name: "InterVariable-Bold", size: 18)
            countryCodeField.textAlignment = .center
            countryCodeField.keyboardType = .phonePad
            countryCodeField.delegate = self
        }
    }
    
    @IBOutlet weak var phoneNumberView: UIView!
    @IBOutlet weak var phoneNumberField: UITextField! {
        didSet {
            phoneNumberField.font = UIFont(name: "InterVariable-Bold", size: 18)
            phoneNumberField.textAlignment = .center
            phoneNumberField.keyboardType = .phonePad
            phoneNumberField.delegate = self
        }
    }
    
    @IBOutlet weak var otpView: UIView!
    @IBOutlet weak var otpField: UITextField! {
        didSet {
            otpField.font = UIFont(name: "InterVariable-Bold", size: 18)
            otpField.textAlignment = .center
            otpField.keyboardType = .phonePad
            otpField.delegate = self
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
    
    private var countryCode = ""
    private var phoneNumber = ""
    private var otp = ""
    
    private enum State {
        case phoneNumber
        case otp
    }
    
    private var state: State = .phoneNumber
    weak var delegate: LoginScreenDelegateProtocol?
    
    init(delegate: LoginScreenDelegateProtocol? = nil) {
        self.delegate = delegate
        super.init(nibName: "PhoneNumberViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func clickedButton(_ sender: Any) {
        continueButton.isEnabled = false
        phoneNumberField.isEnabled = false
        countryCodeField.isEnabled = false
        otpField.isEnabled = false
        if state == .phoneNumber {
            NetworkManager.instance.requestOTP(countryCode: countryCode,
                                               phoneNumber: phoneNumber) { [weak self] otpGenerated in
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    if otpGenerated {
                        heading.text = "Enter The \nOTP"
                        subHeading.text = countryCode + " " + phoneNumber
                        subHeadingIcon.isHidden = false
                        subHeadingIcon.image = UIImage(named: "EditIcon")
                        phoneNumberView.isHidden = true
                        countryCodeView.isHidden = true
                        otpView.isHidden = false
                        otpField.isEnabled = true
                        otpField.becomeFirstResponder()
                        continueButton.isEnabled = true
                        countdownText.isHidden = false
                        state = .otp
                    } else {
                        //phoneNumberField.text = phoneNumber
                        //countryCodeField.text = countryCode
                        continueButton.isEnabled = true
                        phoneNumberField.isEnabled = true
                        countryCodeField.isEnabled = true
                    }
                }
            }
        } else {
            NetworkManager.instance.verifyOTP(countryCode: countryCode, 
                                              phoneNumber: phoneNumber,
                                              otp: otp) { [weak self] result in
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    switch result {
                    case .success(let notesViewModel):
                        self.dismiss(animated: true) { [weak self] in
                            guard let self else { return }
                            self.delegate?.loadNotesScreen(with: notesViewModel)
                        }
                    case .failure(let failure):
                        continueButton.isEnabled = true
                        otpField.isEnabled = true
                    }
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        countryCodeField.becomeFirstResponder()
    }
}

extension PhoneNumberViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField === phoneNumberField {
            self.phoneNumber = textField.text ?? ""
        } else if textField === countryCodeField {
            self.countryCode = textField.text ?? ""
        } else {
            self.otp = textField.text ?? ""
        }
    }
}
