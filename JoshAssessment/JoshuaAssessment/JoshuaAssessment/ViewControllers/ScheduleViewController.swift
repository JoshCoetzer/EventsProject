//
//  ScheduleViewController.swift
//  JoshuaAssessment
//
//  Created by Joshua Coetzer on 2022/09/05.
//

import UIKit

class ScheduleViewController: UIViewController {
    private let viewModel: ScheduleViewModel
    private let group = DispatchGroup()
    
    @IBOutlet private weak var schedulesTableView: UITableView!
    
    required init?(coder aDecoder: NSCoder) {
        viewModel = ScheduleViewModel()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        group.enter()
        viewModel.getSchedulesData(group: group)
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
        self.viewModel.getSchedulesData(group: group)
        self.schedulesTableView.reloadData()
    }
}

extension ScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.schedules?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = schedulesTableView.dequeueReusableCell(withIdentifier: "EventScheduleTableViewCell", for: indexPath) as? EventScheduleTableViewCell {
            
            guard let url = URL(string: viewModel.schedules![indexPath.row].image) else { return UITableViewCell() }
            cell.populateCell(thumbnailImageUrl: url,
                              title: viewModel.schedules?[indexPath.row].title,
                              subtitle: viewModel.schedules?[indexPath.row].subtitle,
                              date: viewModel.schedules?[indexPath.row].date)
            
            return cell
        }

        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Bundle.main.object(forInfoDictionaryKey: "GenericRowHeight") as! CGFloat
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        schedulesTableView.deselectRow(at: indexPath, animated: true)
    }
}
