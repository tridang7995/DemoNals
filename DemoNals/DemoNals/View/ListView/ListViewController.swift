//
//  ListViewController.swift
//  DemoNals
//
//  Created by Tri Dang on 29/12/2021.
//

import Combine
import UIKit

class ListViewController: UIViewController {
    @IBOutlet var tableView: UITableView!

    private var viewModel: ListViewModel?
    private var cancellable = Set<AnyCancellable>()
    var refreshCtr = UIRefreshControl()
    init(_ viewModel: ListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupListenner()
        setupPullRefresh()
        setupNavigation(tittle: "ListView", leftButton: nil, rightButton: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.loadData()
    }

    private func setupListenner() {
        viewModel?.listenerReload.sink(receiveValue: { [weak self] isReload in
            guard let self = self else { return }
            if isReload {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.refreshCtr.endRefreshing()
                }
            }
        }).store(in: &cancellable)
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ListCell", bundle: nil), forCellReuseIdentifier: "ListCell")
    }

    private func setupPullRefresh() {
        refreshCtr.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshCtr.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshCtr)
    }

    @objc func refresh(_ sender: AnyObject) {
        refreshCtr.beginRefreshing()
        viewModel?.loadData()
    }
    
    private func didSelectRow(At indexPath: IndexPath) {
        navigationController?.pushViewController(UserDetailViewController(UserDetailViewModel(viewModel?.datas[indexPath.row])), animated: true)
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.datas.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as? ListCell {
            cell.setup(data: viewModel?.datas[indexPath.row] ?? nil)
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRow(At: indexPath)
    }
}
