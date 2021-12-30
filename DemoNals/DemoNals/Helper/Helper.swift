//
//  Helper.swift
//  DemoNals
//
//  Created by Tri Dang on 30/12/2021.
//

import Foundation

class Helper {
    static func saveDatas(datas: [DataModel]) {
        let dataArray = ArraySaved(datas: datas)
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(dataArray) {
            UserDefaults.standard.set(encoded, forKey: "SavedPerson")
        }
    }

    static func loadDatas() -> [DataModel] {
        var datas: [DataModel] = []
        if let arraySaved = UserDefaults.standard.object(forKey: "SavedPerson") as? Data {
            let decoder = JSONDecoder()
            if let loadDatas = try? decoder.decode(ArraySaved.self, from: arraySaved) {
                datas = loadDatas.datas
            }
        }
        return datas
    }
}
