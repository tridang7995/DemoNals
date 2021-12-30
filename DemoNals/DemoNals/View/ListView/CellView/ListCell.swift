//
//  ListCell.swift
//  DemoNals
//
//  Created by Tri Dang on 29/12/2021.
//

import UIKit

class ListCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var urlDetailLabel: UILabel!
    @IBOutlet var avatarImageView: UIImageView!
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
    }

    func setup(data: DataModel?) {
        guard let data = data else { return }
        titleLabel.text = data.login
        urlDetailLabel.text = data.eventsUrl
        loadImage(urlString: data.avatarUrl)
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
