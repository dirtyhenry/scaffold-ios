//
//  ViewController.swift
//  scaffold
//
//  Created by Mickaël Floc'hlay on 25/11/2019.
//  Copyright © 2019 mickf.net. All rights reserved.
//

import UIKit

struct Login: Codable {
    let username: String
    let password: String
}

class ViewController: UIViewController {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var login: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func handleLogin(_ sender: Any) {
        guard let username = username.text, let password = password.text else {
            return debugPrint("At least 1 field is nil")
        }
        
        let loginBody = Login(username: username, password: password)
        
        let jsonEncoder = JSONEncoder()
        
        var request = URLRequest(url: URL(string: "http://localhost:3000/login")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! jsonEncoder.encode(loginBody)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                return print("An error was met: \(error!)")
            }
            
            guard data != nil else {
                return print("No data was returned")
            }
            
            guard let response = response as? HTTPURLResponse else {
                return print("No HTTP response")
            }
            
            let message = response.statusCode == 201 ? "Logged in OK" : "Logged in NOK \(response.statusCode)"
            
            DispatchQueue.main.async {
                let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true)
            }
        }.resume()
    }
}

