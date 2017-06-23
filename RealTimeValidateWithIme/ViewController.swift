//
//  ViewController.swift
//  RealTimeValidateWithIme
//
//  Created by kikuchy on 2017/06/23.
//  Copyright © 2017年 kikuchy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textField.delegate = self
        self.textField.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
    }
    
    func textDidChange(_ sender: UITextField) {
        if sender.markedTextRange == nil {
            self.show(validationResult: self.validate(text: sender.text ?? ""))
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.show(validationResult: self.validate(text: textField.text ?? ""))
        return true
    }
    
    func show(validationResult: ValidationResult) {
        switch validationResult {
        case .valid:
            self.errorLabel.text = ""
        case .invalid(.isEmpty):
            self.errorLabel.text = "文字を入れてください"
        case .invalid(.shorterThan4):
            self.errorLabel.text = "4文字以上でお願いします"
        case .invalid(.longerThan20):
            self.errorLabel.text = "20文字以内でお願いします"
        }
    }

    func validate(text: String) -> ValidationResult {
        guard !text.isEmpty else {
            return .invalid(.isEmpty)
        }
        guard text.characters.count >= 4 else {
            return .invalid(.shorterThan4)
        }
        guard text.characters.count <= 20 else {
            return .invalid(.longerThan20)
        }
        return .valid
    }
    
    enum ValidationResult {
        case valid
        case invalid(Reason)
        
        enum Reason {
            case isEmpty
            case shorterThan4
            case longerThan20
        }
    }
}

