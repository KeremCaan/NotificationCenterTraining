//
//  DecryptViewController.swift
//  NeonAcademyNotificationCenter
//
//  Created by Kerem Caan on 31.07.2023.
//

import UIKit
import SnapKit

class DecryptViewController: UIViewController {
    let infoLabel = UILabel()
    let decryptedLabel = UILabel()
    let password = "12345"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        decryptCode()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "decrypted"), object: nil, userInfo: ["text":password])
    }
    func setUpView() {
        view.backgroundColor = .systemBackground
        
        //infoLabel
        view.addSubview(infoLabel)
        infoLabel.text = "Şifre Çözülüyor..."
        infoLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        infoLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
        }
        
        //decryptedLabel
        view.addSubview(decryptedLabel)
        decryptedLabel.isHidden = true
        decryptedLabel.text = password
        decryptedLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        decryptedLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(infoLabel.snp.bottom).offset(50)
        }
        
    }
    
    func decryptCode(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.infoLabel.text = "Şifre Çözüldü"
            self.decryptedLabel.isHidden = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.dismiss(animated: true)
                
            }
        }
    }
}
