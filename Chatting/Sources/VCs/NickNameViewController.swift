//
//  nickNameViewController.swift
//  Chatting
//
//  Created by 선민재 on 2022/07/14.
//

import UIKit
import Then
import SnapKit

final class NickNameViewController: UIViewController {
    private let bounds = UIScreen.main.bounds
    
    func addKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    
    @objc func keyboardWillShow(_ noti: NSNotification){
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue{
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.view.frame.origin.y -= keyboardHeight
        }
    }
    
    @objc func keyboardWillHide(_ noti: NSNotification){
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue{
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.view.frame.origin.y += keyboardHeight
        }
    }
    
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    func isFilled(_ textField: UITextField) -> Bool {
        guard let text = textField.text, !text.isEmpty else {
            return false
        }
        return true
    }
    
    lazy var textLabel = UILabel().then {
        $0.text = "Who Are You? \n 당신의 닉네임을 입력하세요"
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.font = UIFont(name: "NotoSansKR-Regular", size: 22)
    }
    
    lazy var wrongText = UILabel().then {
        $0.text = "닉네임을 입력해주세요"
        $0.textColor = .wrong
        $0.font = UIFont(name: "NotoSansKR-Regular", size: 12)
    }
    
    lazy var nickNameField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(string: "닉네임 입력", attributes: [NSAttributedString.Key.foregroundColor : UIColor.placeholder!])
        $0.textAlignment = .center
        $0.layer.cornerRadius = 25
        $0.layer.backgroundColor = UIColor.white.cgColor
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.1
        $0.layer.shadowRadius = 8
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    lazy var enterButton = UIButton().then {
        let text = NSAttributedString(string: "입장하기")
        $0.setAttributedTitle(text, for: .normal)
        $0.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 18)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.backgroundColor = .mainColor
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(enterAction), for: .touchUpInside)
    }
    
    @objc func enterAction() {
        if isFilled(nickNameField) {
            let vc = ChattingViewController()
            self.navigationController?.setViewControllers([vc], animated: true)
        }
        
        else {
            nickNameField.layer.borderWidth = 2
            nickNameField.layer.borderColor = UIColor.wrong?.cgColor
            nickNameField.attributedPlaceholder = NSAttributedString(string: "닉네임 입력", attributes: [NSAttributedString.Key.foregroundColor : UIColor.wrong!])
            view.addSubview(wrongText)
            wrongText.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalTo(nickNameField.snp.top).offset(60)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backGround
        addView()
        setLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.addKeyboardNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.removeKeyboardNotifications()
    }
    
    private func addView() {
        [textLabel, nickNameField, enterButton].forEach {
            view.addSubview($0)
        }
    }
    
    private func setLayout() {
        textLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(292)
        }
        nickNameField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(textLabel.snp.top).offset(200)
            $0.size.equalTo(bounds.height * 0.06)
            $0.trailing.equalToSuperview().offset(-50)
        }
        enterButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(nickNameField.snp.top).offset(200)
            $0.size.equalTo(bounds.height * 0.06)
            $0.trailing.equalToSuperview().offset(-50)
        }
    }

}
