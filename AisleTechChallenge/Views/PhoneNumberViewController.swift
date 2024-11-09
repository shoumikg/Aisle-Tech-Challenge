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
    
    @IBOutlet weak var subHeadingIcon: UIImageView! {
        didSet {
            subHeadingIcon.image = UIImage(named: "EditIcon")
            subHeadingIcon.isUserInteractionEnabled = true
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickedEditIcon(tapGestureRecognizer:)))
            subHeadingIcon.addGestureRecognizer(tapGestureRecognizer)
            subHeadingIcon.isHidden = true
        }
    }
    
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
    
    private var state: State = .phoneNumber {
        didSet {
            switch state {
            case .otp:
                showOtpScreen()
                startCountdown()
            case .phoneNumber: showPhoneNumberScreen()
            }
        }
    }
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
    
    private func showPhoneNumberScreen() {
        heading.text = "Enter Your \nPhone Number"
        subHeading.text = "Get OTP"
        subHeadingIcon.isHidden = true
        phoneNumberView.isHidden = false
        countryCodeView.isHidden = false
        otpView.isHidden = true
        continueButton.isEnabled = true
        phoneNumberField.isEnabled = true
        countryCodeField.isEnabled = true
        countdownText.isHidden = true
    }
    
    private func showOtpScreen() {
        heading.text = "Enter The \nOTP"
        subHeading.text = countryCode + " " + phoneNumber
        subHeadingIcon.isHidden = false
        phoneNumberView.isHidden = true
        countryCodeView.isHidden = true
        otpView.isHidden = false
        otpField.isEnabled = true
        otpField.becomeFirstResponder()
        continueButton.isEnabled = true
        countdownText.isHidden = false
    }
    
    private func showLoadingScreen() {
        continueButton.isEnabled = false
        phoneNumberField.isEnabled = false
        countryCodeField.isEnabled = false
        otpField.isEnabled = false
        subHeadingIcon.isHidden = true
    }
    
    private var timeLeftForOTP: Int = 59 {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.countdownText.text = String(format: "00:%02d", self.timeLeftForOTP)
            }
        }
    }

    private var countdownTimer: Timer?

    private func startCountdown() {
        // Stop any existing countdown before starting a new one
        countdownTimer?.invalidate()
        timeLeftForOTP = 59
        
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0,
                                              repeats: true) { [weak self] timer in
            guard let self else {
                timer.invalidate()
                return
            }
            
            if self.timeLeftForOTP > 0 {
                self.timeLeftForOTP -= 1
            } else {
                timer.invalidate()
                state = .phoneNumber
                otp = ""
            }
        }
    }
    
    @objc func clickedEditIcon(tapGestureRecognizer: UITapGestureRecognizer) {
        state = .phoneNumber
        otp = ""
    }
    
    @IBAction func clickedButton(_ sender: Any) {
        showLoadingScreen()
        if state == .phoneNumber {
            NetworkManager.instance.requestOTP(countryCode: countryCode,
                                               phoneNumber: phoneNumber) { [weak self] otpGenerated in
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    if otpGenerated {
                        state = .otp
                    } else {
                        phoneNumberField.shake(count: 2, for: 0.15)
                        countryCodeField.shake(count: 2, for: 0.15)
                        showPhoneNumberScreen()
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
                            timeLeftForOTP = 0
                            self.delegate?.loadNotesScreen(with: notesViewModel)
                        }
                    case .failure(_):
                        showOtpScreen()
                        otpField.shake(count: 2, for: 0.15)
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
    
    override func viewWillDisappear(_ animated: Bool) {
        countdownTimer?.invalidate()
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
