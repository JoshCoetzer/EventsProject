//
//  ViewController.swift
//  JoshuaAssessment
//
//  Created by Joshua Coetzer on 2022/09/05.
//

import UIKit

class EventsViewController: UIViewController {
    let viewModel: EventsViewModel
    let group = DispatchGroup()

    @IBOutlet weak var eventsTableView: UITableView!
    
    required init?(coder aDecoder: NSCoder) {
        viewModel = EventsViewModel()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        group.enter()
        getEventsData()
        group.notify(queue: .main) {
            self.setupUI()
        }
    }

    private func setupUI() {
        eventsTableView.dataSource = self
        eventsTableView.delegate = self
        registerCell()
        eventsTableView.reloadData()
    }
    
    private func registerCell() {
        let eventCell = UINib(nibName: "EventScheduleTableViewCell", bundle: nil)
        eventsTableView.register(eventCell, forCellReuseIdentifier: "EventScheduleTableViewCell")
    }
    
    private func getEventsData() {
        guard let url = URL(string: String.eventsUrl) else { return }
        
        URLSession.shared.fetchEvents(at: url) { result in
            switch result {
            case .success(let events):
                self.viewModel.setEvents(with: events)
                self.group.leave()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.events?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = eventsTableView.dequeueReusableCell(withIdentifier: "EventScheduleTableViewCell", for: indexPath) as? EventScheduleTableViewCell {
            if let url = URL(string: viewModel.events![indexPath.row].image) {
                cell.thumbnailImageView.load(url: url)
            }
            cell.titleLabel.text = viewModel.events?[indexPath.row].title
            cell.subtitleLabel.text = viewModel.events?[indexPath.row].subtitle
            cell.dateLabel.text = viewModel.events?[indexPath.row].date
            return cell
        }

        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
