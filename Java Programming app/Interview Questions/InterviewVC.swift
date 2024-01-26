////
////  InterviewVC.swift
////  Java Programming app
////
////  Created by Jon Snow on 10/01/24.
////
//
//import UIKit
//struct InterviewQuestions : Codable{
//    var questions : String?
//    var answers : String?
//}
//
//class InterviewVC: UIViewController {
//    var InterviewArray = [InterviewQuestions]()
//    
//    @IBOutlet weak var tableView: UITableView!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.delegate = self
//        tableView.dataSource = self
//        InterviewAPI()
//    }
//    func InterviewAPI(){
//        guard let url = URL(string:"") else { return }
//        let request = URLRequest (url: url)
//        
//        URLSession.shared.dataTask(with: request){data, response, error in
//            if let error = error{
//                print(error.localizedDescription)
//                return
//            }
//            if let data = data{
//                do{
//                    let data = try JSONDecoder().decode([InterviewQuestions].self, from: data)
//                    //                    print (data)
//                    self.InterviewArray = data
//                    
//                }catch{
//                    print("Error in do Block")
//                    
//                }
//                
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//                
//            }
//            
//        }.resume()
//        
//    }
//}
//    extension InterviewVC: UITableViewDelegate, UITableViewDataSource{
//        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            return InterviewArray.count
//        }
//        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            <#code#>
//        }
//    }
//
