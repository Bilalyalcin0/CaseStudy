//
//  HomeViewController.swift
//  CaseStudy-BilalYalcin
//
//  Created by Bilal Yalcin on 14.11.2022.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController,NetworkActivityIndicatorPresentable {
    
    @IBOutlet weak var apiKeyTxtField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setValues()
        setupNotification()
    }
        
    func setupNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterBackground), name: UIScene.didEnterBackgroundNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIScene.willEnterForegroundNotification, object: nil)
    }
    
    private func setValues(){
        apiKeyTxtField.placeholder = "API KEY"
    }
    
    func checkTextFieldIsEmpty() -> Bool {
        if let apiKey = apiKeyTxtField.text, !apiKey.isEmpty {
            return true
        }
        return false
    }
    
    @IBAction func submitButtonAction(_ sender: Any) {
        if checkTextFieldIsEmpty() == true {
            performSegue(withIdentifier: segueIdentifier, sender: nil)
        }else {
            createAlert()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == segueIdentifier) {
            let controller = segue.destination as? WeatherConditionViewController
            if let apiKey = apiKeyTxtField.text, !apiKey.isEmpty{
                    controller?.apiKeyfromHomeVC = apiKey
            }
        }
    }
    
    func createAlert() {
        let alert = UIAlertController(title: warningTitle, message: warningMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: warningButtonTitle, style: .default))
        self.present(alert, animated: true)
    }
    
    @objc func didEnterBackground(notification:NSNotification) {
        print("ViewController " + #function)
    }
    
    @objc func willEnterForeground(notification:NSNotification) {
        print("ViewController " + #function)
    }
}
