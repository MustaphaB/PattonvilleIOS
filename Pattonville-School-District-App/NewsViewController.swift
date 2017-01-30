//
//  NewsViewController.swift
//  Pattonville School District App
//
//  Created by Developer on 9/28/16.
//  Copyright © 2017 Pattonville School District. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, XMLParserDelegate, UISearchControllerDelegate, UISearchResultsUpdating {
    
    var refreshControl: UIRefreshControl!
    
    @IBOutlet var tableView: UITableView!
    
    var carouselWidth: CGFloat = 0
    var carouselHeight: CGFloat = 0
    
    var newsReel: NewsReel!
    var filteredNewsReel: NewsReel!
    
    var schools: [School]!
    var parser: NewsParser!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredNewsReel = NewsReel()
        
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        searchController.searchBar.scopeButtonTitles = []
        tableView.tableHeaderView = searchController.searchBar
        
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.backgroundColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
        self.refreshControl.tintColor = .white
        self.refreshControl.addTarget(self, action: #selector(NewsViewController.refreshData), for: UIControlEvents.valueChanged)
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            // Fallback on earlier versions
            tableView.addSubview(refreshControl)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        schools = SchoolsArray.getSubscribedSchools()
        parser = NewsParser(newsReel: newsReel, schools: schools)
        
        refreshData()
        
        tableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewsDetailViewSegue"{
            let destination = segue.destination as! NewsDetailViewController
            destination.news = newsReel.news[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    // TABLE VIEW STUFF
    
    /// Gives the number of rows needed for the table view under the carousel
    ///
    /// - parameter tableView: the TableView that displays the short news info pieces under the carousel
    /// - parameter section:   the number of sections in the Table View, is 1
    ///
    /// - returns: the number of news stories in the newsReel used to populated the TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != ""{
            return filteredNewsReel.news.count
        }else{
            return newsReel.news.count
        }
    }
    
   
    /// Method to create the cells for the table view under the carousel in News
    ///
    /// - parameter tableView: the table view under the carousel in News
    /// - parameter indexPath: the row the user selects on the table view under the carousel in News
    ///
    /// - returns: none
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsItemCell", for: indexPath) as! NewsItemCell
        
        let newsItem: NewsItem
        
        if searchController.isActive && searchController.searchBar.text != ""{
            newsItem = filteredNewsReel.news[indexPath.row]
        }else{
            newsItem = newsReel.news[indexPath.row]
        }
        
        
        cell.title.text = newsItem.title
        cell.date.text = newsItem.dateString
        
        cell.school.layer.cornerRadius = cell.school.frame.height/2
        cell.school.backgroundColor = newsItem.school.color
        cell.schoolName.text = newsItem.school.shortName
        
        return cell
        
    }
    
    
    func updateSearchResults(for: UISearchController) {
        
        print(filteredNewsReel.news.count)
        
        filterNewsForSearchText(searchText: searchController.searchBar.text!)
        
        print(filteredNewsReel.news.count)
        
    }
    
    // PRIVATE FUNCTIONS
    
    //Refreshes the list of news articles
    @objc private func refreshData(){
        
        parser.updateSchools(schools: schools)
        
        parser.getDataInBackground(completionHandler: {
            print("REFRESHING")
            
            self.newsReel.news.sort(by: {
                return $0.date > $1.date
            })
            
            self.tableView.reloadData()
        })
        
        
        self.refreshControl.endRefreshing()
    }
    
    private func filterNewsForSearchText(searchText: String){
        
        filteredNewsReel.news = newsReel.news.filter({ newsItem in
            return newsItem.title.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
        
    }

    
}


