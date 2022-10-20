//
//  PeopleVC.swift
//  LBG Tech Test
//
//  Created by Nithin Cheruthala on 20/10/2022.
//

import UIKit

class PeopleVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet{
            tableView.register(UINib(nibName: PeopleTVCell.nibName, bundle: nil), forCellReuseIdentifier: PeopleTVCell.defaultReuseIdentifier)
        }
    }
    private var peopleListVM: PeopleListViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
    }
    
    private func setUp(){
        let expectedData = OutPutData<[People]>(endPoind: "people")
        WebService().getResponse(endPoint: expectedData) { result in
            switch result {
            case .success(let people):
                self.peopleListVM = PeopleListViewModel(people: people)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.hashValue)
            }
        }
    }
}
extension PeopleVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.peopleListVM == nil ? 0 : 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.peopleListVM.numberOfRowsInSection(section)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PeopleTVCell.defaultReuseIdentifier, for: indexPath) as? PeopleTVCell else {
            fatalError("Cell not found")
        }
        let peopleVM = self.peopleListVM.peopleAtIndex(indexPath.row)
        cell.bindData(peopleVM)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
    }
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let mailAction = UIContextualAction(style: .normal, title:  "mail", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            if let url = URL(string: "mailto:\(self.peopleListVM.peopleAtIndex(indexPath.row).email)") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            success(true)
        })
        mailAction.image = UIImage(systemName: "paperplane")
        mailAction.backgroundColor = .lightGray
        return UISwipeActionsConfiguration(actions: [mailAction])
    }
}
