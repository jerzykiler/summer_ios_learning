//
//  ViewController.swift
//  SummeriOS1
//
//  Created by Damian Tchorek on 15.03.2016.
//  Copyright © 2016 Damian Tchorek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        printTrends()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func printTrends() -> Void {
        var names = [String]()
        if let jsonData = readTrends() {
            
            let _nsdata = jsonData.dataUsingEncoding(NSUTF8StringEncoding)
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(_nsdata!, options: .AllowFragments)
                
                if let trends = json["trends"] as? [[String: AnyObject]] {
                    for trend in trends {
                        if let name = trend["name"] as? String {
                            names.append(name)
                        }
                    }
                }
            } catch {
                print("error serializing JSON: \(error)")
            }
            
            for name in names{
                print(name) // ["Bloxus test", "Manila Test"]
            }
        }
    }
    
    func readTrends() -> String? {
        if let path = NSBundle.mainBundle().pathForResource("trends", ofType: "json"){
            
            var fileContents: String? = nil
            do {
                fileContents = try String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
            } catch _ as NSError {
                return nil
            }
            return fileContents
        } else {
            return nil
        }
    }
    
}

