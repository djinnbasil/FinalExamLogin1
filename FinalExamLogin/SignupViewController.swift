//
//  SignupViewController.swift
//  FinalExamLogin
//
//  Created by macbook on 2019-12-04.
//  Copyright © 2019 macbook. All rights reserved.
//

import UIKit
import SQLite3


class SignupViewController: UIViewController {
    
     var db: OpaquePointer?
    
    @IBOutlet weak var imageview1: UIImageView!
    
    @IBOutlet weak var emailtext1: UITextField!
    
    @IBOutlet weak var passwordtext1: UITextField!
    
    @IBOutlet weak var passwordtext11: UITextField!
    
    @IBOutlet weak var usernametext: UITextField!
    
    @IBOutlet weak var biotext1: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("Finalexam4.sqlite")
        
        //opening the database
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        else{
            biotext1.text = "OK!!"
        }
        
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Heroes (id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, email TEXT, password TEXT,bio TEXT)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func signupbtn1(_ sender: Any) {
        
        if(passwordtext1.text == passwordtext11.text){
            
            
            let username = usernametext.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailtext1.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordtext1.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let bio = biotext1.text?.trimmingCharacters(in: .whitespacesAndNewlines)
           
            
            if(username?.isEmpty)!{
                usernametext.layer.borderColor = UIColor.red.cgColor
                return
            }
            
            if(email?.isEmpty)!{
                emailtext1.layer.borderColor = UIColor.red.cgColor
                return
            }
            
            var stmt: OpaquePointer?
            
            let queryString = "INSERT INTO Heroes (username, email, password, bio) VALUES (?,?,?,?)"
            
           /*8 if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("error preparing insert: \(errmsg)")
                return
            }
            
            if sqlite3_bind_text(stmt, 1, username, -1, nil) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("failure binding name: \(errmsg)")
                return
            }
            if sqlite3_bind_text(stmt, 2, email, -1, nil) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("failure binding name: \(errmsg)")
                return
            }
            if sqlite3_bind_text(stmt, 1, password, -1, nil) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("failure binding name: \(errmsg)")
                return
            }
            if sqlite3_bind_text(stmt, 4, bio, -1, nil) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("failure binding name: \(errmsg)")
                return
            }
            
            
            
            if sqlite3_step(stmt) != SQLITE_DONE {
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                biotext1.text = errmsg
                return
            }*/
            
            if sqlite3_exec(db, "INSERT INTO Heroes (username,email,password,bio) VALUES('"+username!+"','"+email!+"','"+password!+"','"+bio!+"');", nil, nil, nil) != SQLITE_OK {
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("error creating table: \(errmsg)")
            }
            
            let queryStatementString = "SELECT * FROM Heroes;"
            
            var queryStatement: OpaquePointer? = nil
            // 1
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                // 2
                if sqlite3_step(queryStatement) == SQLITE_ROW {
                    // 3
                    let id = sqlite3_column_int(queryStatement, 0)
                    
                    // 4
                    let queryResultCol1 = sqlite3_column_text(queryStatement, 1)
                    let queryResultCol2 = sqlite3_column_text(queryStatement, 2)
                    let queryResultCol3 = sqlite3_column_text(queryStatement, 3)
                     let queryResultCol4 = sqlite3_column_text(queryStatement, 4)
                    let name = String(cString: queryResultCol1!)
                    let email = String(cString: queryResultCol2!)
                    let password = String(cString: queryResultCol3!)
                    let bio = String(cString: queryResultCol4!)
                    
                    // 5
                    print("Query Result:")
                    print("\(id) | \(name) | \(email) | \(password) | \(bio)")
                    
                } else {
                    print("Query returned no results")
                }
            } else {
                print("SELECT statement could not be prepared")
            }
            
            // 6
            sqlite3_finalize(queryStatement)
        
            
           
            
          
            
            biotext1.text = passwordtext1.text
            
         //performSegue(withIdentifier: "SignUptoLogin", sender: nil)
    }
        else{
            biotext1.text = "Passwords dont match!!"
        }
    
        
    }
}
