//
//  UserDetailViewController.swift
//  DemoNals
//
//  Created by Tri Dang on 30/12/2021.
//

import Combine
import UIKit

class UserDetailViewController: UIViewController {
    var viewModel: UserDetailViewModel
    private var cancellable = Set<AnyCancellable>()
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var countPublicRepoLabel: UILabel!
    @IBOutlet var countFollowerLabel: UILabel!
    @IBOutlet var countFollowingLabel: UILabel!

    init(_ viewModel: UserDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation(tittle: "Profile", leftButton: nil, rightButton: nil)
        viewModel.loadData()
        viewModel.listenerReload.sink { [weak self] isReload in
            guard let self = self else { return }
            if isReload {
                DispatchQueue.main.async {
                    self.setup()
                }
            }
        }
        .store(in: &cancellable)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    func setup() {
        guard let user = viewModel.userProfile else { return }
        userNameLabel.text = user.name
        locationLabel.text = user.location
        loadImage(urlString: user.avatarUrl)
        countFollowerLabel.text = String(user.followers)
        countFollowingLabel.text = String(user.following)
        countPublicRepoLabel.text = String(user.publicRepos)
    }

    func loadImage(urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else { return }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.avatarImageView.image = image
                    }
                }
            }
        }
    }
}
