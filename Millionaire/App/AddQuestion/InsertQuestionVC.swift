//
//  InsertQuestionVC.swift
//  Millionaire
//
//  Created by Алексей Сигай on 13/03/2019.
//  Copyright © 2019 Алексей Сигай. All rights reserved.
//

import UIKit

class InsertQuestionVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainBackgroundView: UIView!
    
    @IBOutlet weak var questionText: UITextView!
    
    @IBOutlet weak var answer1: UITextField!
    @IBOutlet weak var answer2: UITextField!
    @IBOutlet weak var answer3: UITextField!
    @IBOutlet weak var answer4: UITextField!

    deinit {
        // Stop Notification
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        view.addTapGestureToHideKeyboard()
        addObservers()
        configureTextFields()
        
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc private func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        let keyboardHeight = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)!.cgRectValue.height
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        scrollView.contentInset = contentInset
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        scrollView.contentInset = UIEdgeInsets.zero
    }
    private func configureTextFields() {
        self.answer1.delegate = self
        self.answer2.delegate = self
        self.answer3.delegate = self
        self.answer4.delegate = self
    }
    
    
    private func setupView() {
        
        // Стиль окна ввода текста
        questionText.layer.borderWidth = 1.0
        questionText.layer.cornerRadius = 5.0
        questionText.layer.borderColor = UIColor.lightGray.cgColor
        
        // Выбор высоты mainBackgroundView
        let safeAreaFrame = self.view.safeAreaLayoutGuide.layoutFrame
        if safeAreaFrame.height < 650 {
            mainBackgroundView.frame = CGRect(
                origin: mainBackgroundView.frame.origin,
                size: CGSize(
                    width: mainBackgroundView.frame.width,
                    height: 600))
        }
        
    }
    



}

extension UIView {
    // Hide Keyboard by tapping the screen
    
    func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        addGestureRecognizer(tapGesture)
    }
    
    var topSuperview: UIView? {
        var view = superview
        while view?.superview != nil {
            view = view!.superview
        }
        return view
    }
    
    @objc private func dismissKeyboard() {
        topSuperview?.endEditing(true)
    }
}
