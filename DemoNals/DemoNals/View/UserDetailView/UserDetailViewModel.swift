//
//  UserDetailViewModel.swift
//  DemoNals
//
//  Created by Tri Dang on 30/12/2021.
//

import Combine
import Foundation

class UserDetailViewModel: ObservableObject {
    var profile: DataModel?
    var userProfile: UserModel?
    var apiService: APIService
    private var cancellable = Set<AnyCancellable>()
    var listenerReload = PassthroughSubject<Bool, Never>()

    init(_ profile: DataModel?) {
        self.profile = profile
        apiService = APISession()
    }

    func loadData() {
        apiService.requestData(url: "https://api.github.com/users",
                               parameter: ["login": profile?.login ?? ""],
                               typeResponse: userProfile)
            .sink { result in
                switch result {
                case let .success(model):
                    self.userProfile = model
                    self.listenerReload.send(true)
                case .failure:
                    break
                }
            }
            .store(in: &cancellable)
    }
}
