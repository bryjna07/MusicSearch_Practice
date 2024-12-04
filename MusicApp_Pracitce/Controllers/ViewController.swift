//
//  ViewController.swift
//  MusicApp_Pracitce
//
//  Created by t2023-m0033 on 12/4/24.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var musicTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupTableView()
    }


    //테이블뷰 셋팅
    func setupTableView() {
        musicTableView.delegate = self
        musicTableView.dataSource = self
        
    }
    
    
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.musicArrays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // indentifier -> "MusicCell" 을 편하게 쓰도록 NameSpace
        let cell = musicTableView.dequeueReusableCell(withIdentifier: Cell.musicCellIdentifier, for: indexPath) as! MusicCell
        
        
        
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
}
