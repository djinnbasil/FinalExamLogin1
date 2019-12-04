//
//  ViewController.swift
//  FinalExamLogin
//
//  Created by macbook on 2019-12-04.
//  Copyright © 2019 macbook. All rights reserved.
//

import UIKit
import SQLite3

class ViewController: UIViewController {
       var db: OpaquePointer?
    var heroList = [User]()
    
    @IBOutlet weak var emailtext: UITextField!
    
    @IBOutlet weak var testtext: UITextView!
    @IBOutlet weak var passwordtext: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("Finalexam1.sqlite")
        
        //opening the database
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        // Do any additional setup after loading the view.
    }
    
    
    func readValues(){
        heroList.removeAll()
        
        let queryString = "SELECT * FROM Heroes"
        
        var stmt:OpaquePointer?
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            emailtext.text = errmsg
            return
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = sqlite3_column_int(stmt, 0)
            let username = String(cString: sqlite3_column_text(stmt, 1))
            let email = sqlite3_column_int(stmt, 2)
            let password = sqlite3_column_int(stmt, 3)
            let bio = sqlite3_column_int(stmt, 4)
            testtext.text += String(heroList.count)
            
            heroList.append(User(id: Int(id), username: String(describing: username),
                email :String(describing: email),
                password : String(describing: password),
                bio :String(describing: bio)))
            
          //  testtext.text = String(heroList[0].username!)
          //  testtext.text += String(heroList[0].password!)
           // testtext.text += String(heroList[0].email!)
           // testtext.text += String(heroList[0].bio!)
            

            
            
            
            
            
        }
        
     //   self.tableViewHeroes.reloadData()
    }
    
    
    
    

    @IBAction func loginbtn(_ sender: Any) {
        readValues()
    }
    
    @IBAction func signupbtn(_ sender: Any) {
        performSegue(withIdentifier: "LogintoSignUp", sender: nil)
    }
}

