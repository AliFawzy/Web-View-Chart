//
//  getVC.swift
//  IOS Test
//
//  Created by aly on 4/2/19.
//  Copyright © 2019 aly. All rights reserved.
//

import UIKit

class getVC: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoginGet(){}
    }
    
    
    var LoginArr = [LoginApiGet]()
    
    func LoginGet(completed:()->())  {
        guard let  url = URL(string: "http://3.92.73.212/index.php/api/customer/testing") else { return  }
        var request = URLRequest(url: url)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        print(UserDefaults.standard.string(forKey: "token") ?? "")
        request.addValue("Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8zLjkyLjczLjIxMlwvaW5kZXgucGhwXC9hcGlcL2N1c3RvbWVyXC9sb2dpbiIsImlhdCI6MTU1NDI0MjA5NiwiZXhwIjoxNTU1NDUxNjk2LCJuYmYiOjE1NTQyNDIwOTYsImp0aSI6IkpHSDVNa2pkeVJmNlFZdm0iLCJzdWIiOjE5MSwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.ZAYq-6VO2tr9ZI1DpGxe_dMHSzmkRY9sDhFcczgMXjY)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil{
                do{
                    self.LoginArr = try JSONDecoder().decode([LoginApiGet].self, from: data!)
                    
                    DispatchQueue.main.async {
                         //print(self.LoginArr)
                      //  print(self.LoginArr[0].array[0])
                         //print(self.LoginArr[0].array[1])
                        self.PieChartHtmlCode()
                    }
                }catch {
                    print(error)
                }
              }
            }.resume()
    }
    
    
    func PieChartHtmlCode() {
        let htmlCode = "<html> <head><script type=\"text/javascript\" src=\"https://www.gstatic.com/charts/loader.js\"></script><script type=\"text/javascript\">google.charts.load(\"current\", {packages:[\"corechart\"]});google.charts.setOnLoadCallback(drawChart);function drawChart() {var data = google.visualization.arrayToDataTable([['الطلبات', 'عدد العمليات'],['\(self.LoginArr[0].array[0])',\(self.LoginArr[0].array[1])],['\(self.LoginArr[1].array[0])',\(self.LoginArr[1].array[1])],['\(self.LoginArr[2].array[0])',\(self.LoginArr[2].array[1])],['\(self.LoginArr[3].array[0])',\(self.LoginArr[3].array[1])],['\(self.LoginArr[4].array[0])',\(self.LoginArr[4].array[1])],['\(self.LoginArr[5].array[0])',\(self.LoginArr[5].array[1])],['\(self.LoginArr[6].array[0])',\(self.LoginArr[6].array[1])]]);var options = {title: 'الطلبات',pieHole: 0.4,};var chart = new google.visualization.PieChart(document.getElementById('donutchart'));chart.draw(data, options);}</script></head><body><div id=\"donutchart\" style=\"width: 500px; height: 500px;\"></div></body></html>"
        webView.loadHTMLString(htmlCode, baseURL: nil)
    }
    
    
    
}
