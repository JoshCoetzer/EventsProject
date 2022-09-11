//
//  EventScheduleTableViewCell.swift
//  JoshuaAssessment
//
//  Created by Joshua Coetzer on 2022/09/07.
//

import UIKit

class EventScheduleTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func populateCell(thumbnailImageUrl: URL, title: String?, subtitle: String?, date: String?) {
        thumbnailImageView.load(url: thumbnailImageUrl)
        titleLabel.text = title
        subtitleLabel.text = subtitle
        dateLabel.text = date
    }
}
