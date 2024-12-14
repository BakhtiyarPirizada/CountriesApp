//
//  QuizController .swift
//  CountryApp
//
//  Created by Bakhtiyar Pirizada on 07.12.24.
//


import UIKit

class QuizController: UIViewController {
    
    enum ViewState {
        case loading
        case loaded
        case success
        case error(String)
    }
    private lazy var quizTable:UITableView = {
        let t = UITableView()
        return t
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
extension QuizController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
}
