//
//  ScheduleViewController.swift
//  JoshuaAssessment
//
//  Created by Joshua Coetzer on 2022/09/05.
//

import UIKit

class ScheduleViewController: UIViewController {
    let viewModel: ScheduleViewModel
    let group = DispatchGroup()
    
    @IBOutlet weak var schedulesTableView: UITableView!
    
    required init?(coder aDecoder: NSCoder) {
        viewModel = ScheduleViewModel()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        group.enter()
        getSchedulesData()
        group.notify(queue: .main) {
            self.setupUI()
            self.startReloadTimer()
        }
    }
    
    private func setupUI() {
        schedulesTableView.dataSource = self
        schedulesTableView.delegate = self
        registerCell()
        schedulesTableView.reloadData()
    }
    
    private func registerCell() {
        let scheduleCell = UINib(nibName: "EventScheduleTableViewCell", bundle: nil)
        schedulesTableView.register(scheduleCell, forCellReuseIdentifier: "EventScheduleTableViewCell")
    }
    
    private func startReloadTimer() {
        let refreshTime = Bundle.main.object(forInfoDictionaryKey: "RefreshTime") as! CGFloat
        let timer = Timer.scheduledTimer(timeInterval: refreshTime, target: self, selector: #selector(reloadTableView), userInfo: nil, repeats: true)
    }
    
    @objc func reloadTableView() {
        self.group.enter()
        self.getSchedulesData()
        self.schedulesTableView.reloadData()
    }
    
    private func getSchedulesData() {
        guard let url = URL(string: String.eventsUrl) else { return }
        
        URLSession.shared.fetchSchedules(at: url) { result in
            switch result {
            case .success(let schedules):
                self.viewModel.setSchedules(with: schedules)
                self.group.leave()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension ScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.schedules?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = schedulesTableView.dequeueReusableCell(withIdentifier: "EventScheduleTableViewCell", for: indexPath) as? EventScheduleTableViewCell {
            if let url = URL(string: viewModel.schedules![indexPath.row].image) {
                cell.thumbnailImageView.load(url: url)
            }
            cell.titleLabel.text = viewModel.schedules?[indexPath.row].title
            cell.subtitleLabel.text = viewModel.schedules?[indexPath.row].subtitle
            cell.dateLabel.text = viewModel.schedules?[indexPath.row].date
            return cell
        }

        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Bundle.main.object(forInfoDictionaryKey: "GenericRowHeight") as! CGFloat
    }
}
