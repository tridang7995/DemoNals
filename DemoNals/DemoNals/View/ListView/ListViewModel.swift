//
//  ListViewModel.swift
//  DemoNals
//
//  Created by Tri Dang on 30/12/2021.
//

import Combine
import UIKit

class ListViewModel: ObservableObject {
    var apiService: APIService
    private var cancellable = Set<AnyCancellable>()
    var listenerReload = PassthroughSubject<Bool, Never>()

    init() {
        apiService = APISession()
    }

    var datas: [DataModel] = []

    // MARK: Input

    func loadData() {
        apiService.requestData(url: "https://api.github.com/users",
                               parameter: nil,
                               typeResponse: datas)
            .sink(receiveValue: { [weak self] result in
                guard let self = self else { return }
                switch result {
                case let .success(model):
                    self.datas = model
                    self.listenerReload.send(true)
                    Helper.saveDatas(datas: model)
                case .failure:
                    self.datas = Helper.loadDatas()
                    self.listenerReload.send(true)
                }
            })
            .store(in: &cancellable)
    }
}
