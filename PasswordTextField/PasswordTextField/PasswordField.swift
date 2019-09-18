//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

enum PasswordStrength: Int {
    case weak = 1
    case medium
    case strong
}

class PasswordField: UIControl {
    
    // Public API - these properties are used to fetch the final password and strength values
    
    private (set) var password: String = ""
    
    private let standardMargin: CGFloat = 8.0
    private let textFieldContainerHeight: CGFloat = 50.0
    private let textFieldMargin: CGFloat = 6.0
    private let colorViewSize: CGSize = CGSize(width: 60.0, height: 5.0)
    
    private let labelTextColor = UIColor(hue: 233.0/360.0, saturation: 16/100.0, brightness: 41/100.0, alpha: 1)
    private let labelFont = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
    
    private let textFieldBorderColor = UIColor(hue: 208/360.0, saturation: 80/100.0, brightness: 94/100.0, alpha: 1)
    private let bgColor = UIColor(hue: 0, saturation: 0, brightness: 97/100.0, alpha: 1)
    
    // States of the password strength indicators
    private let unusedColor = UIColor(hue: 210/360.0, saturation: 5/100.0, brightness: 86/100.0, alpha: 1)
    private let weakColor = UIColor(hue: 0/360, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let mediumColor = UIColor(hue: 39/360.0, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let strongColor = UIColor(hue: 132/360.0, saturation: 60/100.0, brightness: 75/100.0, alpha: 1)
    
    private var titleLabel: UILabel = UILabel()
    private var textField: UITextField = UITextField()
    private var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    
    func setup() {
        // Lay out your subviews here
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        titleLabel.text = "Enter Password"
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
        
        let textfieldContainerView = UIView()
        addSubview(textfieldContainerView)
        textfieldContainerView.translatesAutoresizingMaskIntoConstraints = false
        textfieldContainerView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        textfieldContainerView.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1.0).isActive = true
        textfieldContainerView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        textfieldContainerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textfieldContainerView.layer.borderColor = textFieldBorderColor.cgColor
        textfieldContainerView.layer.borderWidth = 2
        textfieldContainerView.layer.cornerRadius = 5


        textfieldContainerView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leadingAnchor.constraint(equalTo: textfieldContainerView.leadingAnchor, constant: 8).isActive = true
        textField.topAnchor.constraint(equalTo: textfieldContainerView.topAnchor, constant: 8).isActive = true
        textField.trailingAnchor.constraint(equalTo: textfieldContainerView.trailingAnchor, constant: -8).isActive = true
        textField.bottomAnchor.constraint(equalTo: textfieldContainerView.bottomAnchor, constant: -8).isActive = true
        
        addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.leadingAnchor.constraint(equalTo: textfieldContainerView.leadingAnchor, constant: 300).isActive = true
        showHideButton.topAnchor.constraint(equalTo:textfieldContainerView.topAnchor, constant: 15).isActive = true
        showHideButton.trailingAnchor.constraint(equalTo:textfieldContainerView.trailingAnchor, constant: -8).isActive = true
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
        showHideButton.addTarget(self, action: Selector(("")), for: .touchUpInside)
        
    
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.leadingAnchor.constraint(equalTo: textField.leadingAnchor, constant: 0).isActive = true
        weakView.trailingAnchor.constraint(equalTo:titleLabel.trailingAnchor, constant: -270).isActive = true
        weakView.topAnchor.constraint(equalTo: textField.topAnchor, constant: 20)
        weakView.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: 33).isActive = true
        weakView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        weakView.backgroundColor = weakColor
        
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.leadingAnchor.constraint(equalTo: weakView.leadingAnchor).isActive = true
        mediumView.trailingAnchor.constraint(equalTo: textField.trailingAnchor).isActive = true
        mediumView.topAnchor.constraint(equalTo: textField.topAnchor, constant: 40).isActive = true
        mediumView.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: 0).isActive = true
        mediumView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        mediumView.backgroundColor = mediumColor

        
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor, constant: 250).isActive = true
        strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20).isActive = true
        strengthDescriptionLabel.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 20).isActive = true
//        strengthDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10)
        strengthDescriptionLabel.text = "Too Weak"
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.textColor = labelTextColor
        
        
        
    }

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func determineStrength(string: String) {
        var strength = PasswordStrength.weak
        switch string.count {
        case 0...7:
            strength = .weak
        case 8...15:
            strength = .medium
        default:
            strength = .strong
        }
        updateStrength(strength: strength)
    }
    
    func updateStrength(strength: PasswordStrength) {
        switch strength {
        case .weak:
            UIView.animate(withDuration: 0.4) {
                self.weakView.backgroundColor = self.weakColor
                self.weakView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
        case .medium:
            UIView.animate(withDuration: 0.4) {
                self.mediumView.backgroundColor = self.mediumColor
                self.mediumView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
        case .strong:
            UIView.animate(withDuration: 0.4) {
                self.strongView.backgroundColor = self.strongColor
                self.strongView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
        }
    }
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        determineStrength(string: newText)
        return true
    }
}

