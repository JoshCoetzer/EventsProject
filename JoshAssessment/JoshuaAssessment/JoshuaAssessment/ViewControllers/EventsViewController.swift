//
//  ViewController.swift
//  JoshuaAssessment
//
//  Created by Joshua Coetzer on 2022/09/05.
//

import UIKit
import AVKit
import AVFoundation

class EventsViewController: UIViewController {
    private let viewModel: EventsViewModel
    private let group = DispatchGroup()

    @IBOutlet private weak var eventsTableView: UITableView!
    
    required init?(coder aDecoder: NSCoder) {
        viewModel = EventsViewModel()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        group.enter()
        viewModel.getEventsData(group: group)
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
}

extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.events?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = eventsTableView.dequeueReusableCell(withIdentifier: "EventScheduleTableViewCell", for: indexPath) as? EventScheduleTableViewCell {
            guard let url = URL(string: viewModel.events![indexPath.row].image) else { return UITableViewCell() }
            cell.populateCell(thumbnailImageUrl: url,
                              title: viewModel.events?[indexPath.row].title,
                              subtitle: viewModel.events?[indexPath.row].subtitle,
                              date: viewModel.events?[indexPath.row].date)
            return cell
        }

        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Bundle.main.object(forInfoDictionaryKey: "GenericRowHeight") as! CGFloat
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let videoURL = URL(string: viewModel.events![indexPath.row].video)
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
        eventsTableView.deselectRow(at: indexPath, animated: true)
    }
}
