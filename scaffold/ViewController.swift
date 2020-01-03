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
    
    weak var extraView: UIView?
    
    override func viewDidLoad() {
        debugPrint("viewDidLoad")
        super.viewDidLoad()
        view.backgroundColor = .lightGray
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
        
        // Add some view dynamically
        let anotherSubview2 = MyView(frame: .zero)
        anotherSubview2.translatesAutoresizingMaskIntoConstraints = false
        anotherSubview2.backgroundColor = .red
        view.addSubview(anotherSubview2)

        extraView?.removeFromSuperview()
        let anotherSubview = MyView(frame: .zero)
        anotherSubview.translatesAutoresizingMaskIntoConstraints = false
        anotherSubview.backgroundColor = .white
        view.addSubview(anotherSubview)
        extraView = anotherSubview
        anotherSubview.layer.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        anotherSubview.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)

        NSLayoutConstraint.activate([
            anotherSubview2.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8.0),
            anotherSubview2.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8.0),
            anotherSubview2.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8.0),
            anotherSubview2.heightAnchor.constraint(equalToConstant: 256.0),

            anotherSubview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8.0),
            anotherSubview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8.0),
            anotherSubview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8.0),
            anotherSubview.heightAnchor.constraint(equalToConstant: 256.0)
        ])
    }
    
    override func updateViewConstraints() {
        debugPrint("updateViewConstraints \(view.frame) \(extraView?.frame)")
        super.updateViewConstraints()
    }
    
    override func viewWillLayoutSubviews() {
        debugPrint("viewWillLayoutSubviews \(view.frame) \(extraView?.frame)")
    }
    
    override func viewDidLayoutSubviews() {
        debugPrint("viewDidLayoutSubviews \(view.frame) \(extraView?.frame)")
    }
}

