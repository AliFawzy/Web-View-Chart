//
//  ViewController.swift
//  IOS Test
//
//  Created by aly on 4/1/19.
//  Copyright © 2019 aly. All rights reserved.
//

import UIKit

class LogIn: UIViewController {

    
    @IBOutlet weak var EmailLoginTF: UITextField!
    @IBOutlet weak var PassLoginTF: UITextField!
   
  
    var iconClick = true
    @IBAction func ShowPassLogin(_ sender: Any){
        if(iconClick == true) {
            PassLoginTF.isSecureTextEntry = false
        } else {
            PassLoginTF.isSecureTextEntry = true
        }
        
        iconClick = !iconClick
    }
    
        override func viewDidLoad() {
        super.viewDidLoad()
            
            
    }
    
    
    
    @IBAction func LoginBTN(_ sender: Any) {
    
        
        if EmailLoginTF.text != "" && PassLoginTF.text != ""{
            LoginPost(){}
        }
        else{
            let alertController = UIAlertController(title: "Alert", message: "fill empty text fields", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "Cancel", style: .default) { (action:UIAlertAction) in
                print("You've pressed default");
            }
            alertController.addAction(action1)
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    
    
    
    func LoginPost(completed:@escaping ()->())  {
        
        guard let  url = URL(string: "http://3.92.73.212/index.php/api/customer/login") else { return  }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let Login = LoginApiPost(email: EmailLoginTF.text!, password: PassLoginTF.text!)
        
        
                do{
                    let encode = try JSONEncoder().encode(Login)
                    request.httpBody = encode
                }catch {
                   
                }
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil{
                
                do{
                    let ServerResponse = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)as![String:Any]
                    completed()
                    DispatchQueue.main.async {
                        print("Response is \(ServerResponse)")
                        
                        for (key,value) in ServerResponse{
                            if key == "token"{
                                UserDefaults.standard.set("token", forKey: value as! String)
                                
                                if value as! String != ""{
                                    self.performSegue(withIdentifier: "logS", sender: nil)
                                }
                            }
                        }
                    }
                }catch{
                    
                }
                
            }
        }.resume()
    }
    
    

}

