//
//  ViewController.swift
//  MusicApp_Pracitce
//
//  Created by t2023-m0033 on 12/4/24.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var musicTableView: UITableView!
    
    // 네트워크 매니저 (싱글톤)
    var networkManager = NetworkManager.shared
    
    // (음악 데이터를 다루기 위함) 빈배열로 시작
    var musicArrays: [Music] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupTableView()
        setupDatas()
    }


    //테이블뷰 셋팅
    func setupTableView() {
        musicTableView.delegate = self
        musicTableView.dataSource = self
       
        // Nib파일을 사용한다면 등록의 과정이 필요
        musicTableView.register(UINib(nibName: Cell.musicCellIdentifier, bundle: nil), forCellReuseIdentifier: Cell.musicCellIdentifier)
        
        //musicTableView.rowHeight = 120
    }
    
    // 데이터 셋업
    func setupDatas() {
        // 네트워킹의 시작, 시작화면에 아무것도 안나오면 이상하니까 사용
        networkManager.fetchMusic(searchTerm: "gdragon") { result in
            print(#function)
            switch result {
            case .success(let musicDatas):
                // 데이터(배열)을 받아오고 난 후
                self.musicArrays = musicDatas
                // 테이블뷰 리로드  // 클로저 내부에서 캡처현상이 발생할 수 있음 -> self 붙여야함
                // 현재 비동기, 테이블뷰를 다시그리는 코드 -> 메인 쓰레드에서 실행해야함
                // 처음엔 테이블뷰가 빈상태로 나온 후 데이터 받아서 다시 그림
                DispatchQueue.main.async {
                    self.musicTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return self.musicArrays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // indentifier -> "MusicCell" 을 편하게 쓰도록 NameSpace
        let cell = musicTableView.dequeueReusableCell(withIdentifier: Cell.musicCellIdentifier, for: indexPath) as! MusicCell
        
        
        cell.imageUrl = musicArrays[indexPath.row].imageUrl
        
        cell.songNameLabel.text = musicArrays[indexPath.row].songName
        cell.artistNameLabel.text = musicArrays[indexPath.row].artistName
        cell.albumNameLabel.text = musicArrays[indexPath.row].albumName
        cell.releaseDateLabel.text = musicArrays[indexPath.row].releaseDateString
        
        cell.selectionStyle = .none
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    // 테이블뷰 셀의 높이를 유동적으로 조절하고 싶다면 구현할 수 있는 메서드
    // (musicTableView.rowHeight = 120 대신에 사용가능)
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }

}
