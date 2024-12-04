//
//  NetworkManager.swift
//  MusicApp_Pracitce
//
//  Created by t2023-m0033 on 12/4/24.
//

import Foundation

// 일반적으로 싱글톤으로, 여러곳에서 네트워킹을 시도하기 때문
class NetworkManager {
    
    // 변수는 데이터 영역, 실제로 싱글톤은 힙 영역 (한개만)
    static let shared = NetworkManager()
    
    // 다른곳에서 생성하지 못하도록
    private init() {}
    
    
    func fetchMusic() {
        getMethod(completion: <#T##([Music]?) -> Void#>)
    }
    
    
    func getMethod(completion: @escaping ([Music]?) -> Void) {

        // URL구조체 만들기
        guard let url = URL(string: "https://itunes.apple.com/search?media=music&term=g-dragon") else {
            print("Error: cannot create URL")
            completion(nil)
            return
        }
        
        // URL요청 생성   get, post, put delete
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        
        // 요청을 가지고 작업세션시작
        // 세션 - 브라우저의 하나의 탭, 싱글톤
        // get 만 쓸 때 -> dataTask(with: url) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            // 에러가 없어야 넘어감
            guard error == nil else {
                print("Error: error calling GET")
                print(error!)
                completion(nil)
                return
            }
            // 옵셔널 바인딩
            guard let safeData = data else {
                print("Error: Did not receive data")
                completion(nil)
                return
            }
            // HTTP 200번대 정상코드인 경우만 다음 코드로 넘어감
            // 위에서 데이터가 있을 때 넘어오기 때문에 굳이 없어도 되긴함 (but 더 정확한 처리를 위해)
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("Error: HTTP request failed")
                completion(nil)
                return
            }

            // 원하는 모델이 있다면, JSONDecoder로 decode코드로 구현 ⭐️
              do {
                let decoder = JSONDecoder()
                let mussicArray = try decoder.decode(MusicData.self, from: safeData)
                completion(musicData.results)
                return
            } catch {
                
            }
        }.resume()     // 시작
    }
   
    
}
