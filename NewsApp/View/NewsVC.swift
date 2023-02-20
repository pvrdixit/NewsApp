//
//  NewsVC.swift
//  NewsApp
//
//  Created by pvrdixit on 20/02/23.
//

import UIKit

class NewsVC: UIViewController {
    
    @IBOutlet weak var newsTableView: UITableView!
    let newsViewModel : NewsViewModel = NewsViewModel()
    var newsTableData : [Article] = []
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        newsTableViewSetup()
        getNewsByCountry()
    }
    
    private func newsTableViewSetup() {
        newsTableView.register(UINib(nibName: "NewsViewCell", bundle: .main), forCellReuseIdentifier: "NewsViewCell")
        newsTableView.contentInset = UIEdgeInsets(top:0, left: 0, bottom: 50, right: 0)
        newsTableView.delegate = self
        newsTableView.dataSource = self
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
        newsTableView.addSubview(refreshControl)
        let country = UserDefaultUtility().getCountryPreference()
        title = "News - \(country)"
    }
 
    // MARK: Select Country
    @IBAction func selectCountry(_ sender: UIBarButtonItem) {
        let actionSheetController = UIAlertController()
        actionSheetController.title = "Select Country"
        actionSheetController.message = "Please select your preferred country for news"
        let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel",
                                                              style: .cancel) { action -> Void in
        }
        actionSheetController.addAction(cancelActionButton)
        
        let countries = ["United States", "Canada", "India"]
        
        for country in countries {
            let saveActionButton: UIAlertAction = UIAlertAction(title: country,
                                                                style: .default) { action -> Void in

                //Save Preference
                let countryCode = CountryCodePropertyWrapper(_countryName: country).wrappedValue
                UserDefaultUtility().saveCountryPreference(countryCode: countryCode)
                self.title = "News - \(country)"
                self.getNewsByCountry()
            }
            actionSheetController.addAction(saveActionButton)
        }
        
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    
    // MARK: Fetch News

    @objc private func refreshNews()
    {
        refreshControl.endRefreshing()
        getNewsByCountry()
    }
    
    private func getNewsByCountry()
    {
        showSpinner()
        newsViewModel.getNewsByCountry {[weak self] (articles, message) in
            guard let self = self else { return }
            self.removeSpinner()
            self.newsTableData = articles
            if message != nil {
                DispatchQueue.main.async {
                    self.displayAlert(alertMessage: message!)
                    self.newsTableView.reloadData()
                }
            }
            else {
                self.newsTableData = articles
                DispatchQueue.main.async {
                    self.newsTableView.reloadData()
                }
            }
          
        }
    }
    
}


// MARK: TableView Delegates

extension NewsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsTableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsViewCell", for: indexPath) as! NewsViewCell
        cell.selectionStyle = .none
        cell.configure(newsTableData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let urlString = newsTableData[indexPath.row].url
        guard let url = URL(string: urlString) else {
            displayAlert(alertMessage: "Not able to load the page at this moment")
            return
        }
        
        let webVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WebVC") as! WebVC
        webVC.url = url
        webVC.titleName = newsTableData[indexPath.row].source.name
        self.navigationController?.pushViewController(webVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }
}
