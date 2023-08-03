//
//  ViewController.swift
//  NeonAcademyNotificationCenter
//
//  Created by Kerem Caan on 31.07.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    let timerLabel = UILabel()
    let passwordLabel = UILabel()
    let passwordTF = UITextField()
    let decryptButton = UIButton()
    var timer = Timer()
    var counter = 15
    var sonuc = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        NotificationCenter.default.addObserver(self, selector: #selector(showResult(data:)), name: NSNotification.Name(rawValue: "decrypted"), object: nil)
    }

    func setUpView() {
        view.backgroundColor = .systemGray
        
        //timerLabel
        view.addSubview(timerLabel)
        timerLabel.text = "Time : \(counter)"
        timerLabel.font = UIFont.systemFont(ofSize: 32)
        timerLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        //passwordLabel
        view.addSubview(passwordLabel)
        passwordLabel.text = ""
        passwordLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        passwordLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(timerLabel.snp.bottom).offset(20)
        }
        
        //passwordTF
        view.addSubview(passwordTF)
        passwordTF.isHidden = true
        passwordTF.borderStyle = .roundedRect
        passwordTF.placeholder = "Enter the code!"
        passwordTF.isSecureTextEntry = true
        passwordTF.textAlignment = .center
        passwordTF.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(20)
            make.right.equalTo(-20)
            make.left.equalTo(20)
        }
        
        //decryptButton
        view.addSubview(decryptButton)
        decryptButton.configuration = .filled()
        decryptButton.setTitle("Decrypt!", for: .normal)
        decryptButton.addTarget(self, action: #selector(decryptButtonTapped), for: .touchUpInside)
        decryptButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(passwordTF.snp.bottom).offset(20)
        }
        
    }
    
    @objc func decryptButtonTapped(){
        decryptButton.setTitle("Decrypting...", for: .normal)
        decryptButton.isEnabled = false
        passwordTF.isHidden = false
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
        let secondVC = DecryptViewController()
        secondVC.modalPresentationStyle = .fullScreen
        present(secondVC, animated: false)
       
    }
    @objc func timerFunction(){
        if counter > 0 {
            counter -= 1
            timerLabel.text = "Time : \(counter)"
        } else if counter == 0 {
            timerLabel.text = "Time is Over"
            counter -= 1
            passwordTF.isEnabled = false
            if passwordTF.text == sonuc {
                let alert = UIAlertController(title: "Congratulations!", message: "You have entered the correct password.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                timer.invalidate()
            }else {
                let alert = UIAlertController(title: "Error!", message: "You have entered the wrong password.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                timer.invalidate()
            }
        }
    }
    @objc func showResult(data:Notification){
        if let userinfo = data.userInfo {
            sonuc = userinfo["text"] as! String
            self.passwordLabel.text = String(sonuc)
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                self.passwordLabel.text = ""
            }
        }
    }
}




