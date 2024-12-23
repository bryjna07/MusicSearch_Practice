//
//  Constants.swift
//  MusicApp_Pracitce
//
//  Created by t2023-m0033 on 12/4/24.
//

import UIKit

//MARK: - Name Space 만들기

// 데이터 영역에 저장 (열거형, 구조체 다 가능 / 전역 변수로도 선언 가능)
// 사용하게될 API 문자열 묶음
// 열거형은 저장속성을 가질 수 없다, 타입저장속성은 가능
public enum MusicApi {
    static let requestUrl = "https://itunes.apple.com/search?"
    static let mediaParam = "media=music"
}


// 사용하게될 Cell 문자열 묶음
// 생성을 할 수 없게 막아둠, 구조체의 인스턴스를 만들 수 없음 -NameSpace의 목적
// 문자열을 저장하는 저장소 - 실수방지, 구조체나 열거형 타입 저장속성 - 데이터 영역에 생김, 공유하는 데이터처럼 쓸 수 있음
public struct Cell {
    static let musicCellIdentifier = "MusicCell"
    static let savedMusicCellIdentifier = "SavedMusicCell"
    private init() {}
}
