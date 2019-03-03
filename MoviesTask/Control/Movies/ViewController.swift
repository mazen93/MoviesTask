//
//  ViewController.swift
//  MoviesTask
//
//  Created by mac on 2/27/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {
    
    
    // MARK : Outlet
    @IBOutlet weak var allMoviesTableview: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    
    
    
    private  let tableViewCellID="MovieListCell"
    private var array:[MovieListModel]=[]
    private  var moviesArray:[results]=[]
    private  var movieArray:[Movie]=[]
    private var sectionData:[Int:[Any]]=[:]
    private var tableSections:[String]=["My Movies","All Movies"]
   
    // MARK:for pagination
    private var pageNo:Int=1
    private var totalPages:Int=1
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //register the nib of the cell for your cell
        
        allMoviesTableview.register(UINib(nibName: "MovieListCell", bundle: nil), forCellReuseIdentifier: "MovieListCell")
        
        
        sectionData=[0:movieArray,1:moviesArray]
        self.allMoviesTableview.delegate=self
        self.allMoviesTableview.dataSource=self
       loadingIndicator.startAnimating()
        getData(pageNo: pageNo)
    
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        // feetch data
        let fetch:NSFetchRequest<Movie>=Movie.fetchRequest()
        do{
            let movie=try persistentService.context.fetch(fetch)
            self.movieArray=movie
            self.allMoviesTableview.reloadData()
        }catch{}
    }

 
    
    func getData(pageNo:Int)  {
        
        let urlString=URLs.MoviesList+"page=\(pageNo)"
        guard let url=URL(string: urlString) else {
            return
        }
        
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error=error {
                print("error",error)
                
                return
            }
            guard let data = data  else{
                return
            }
            _=String(data: data, encoding: .utf8)
            do{
                let parse=try JSONDecoder().decode(MovieListModel.self, from: data)
                self.pageNo=parse.page!
                self.totalPages=parse.total_pages!
                self.moviesArray.append(contentsOf: parse.results!)
               
                DispatchQueue.main.async {
                    self.loadingIndicator.stopAnimating()
                    self.allMoviesTableview.reloadData()
                }
            }catch{
                print("cant")
            }
            
        }.resume()
        
        
    }
    

}

 

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableSections.count
    }
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
    let cell=tableView.dequeueReusableCell(withIdentifier: tableViewCellID, for: indexPath) as!  MovieListCell
        
        
        switch indexPath.section {
        case 0:
            cell.configrationData(data: movieArray[indexPath.row])
    return cell
        case 1:
            cell.configration(data: moviesArray[indexPath.row])
            return cell
            
        default:
           fatalError("error")
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        
        switch section {
        case 0:
            return movieArray.count
        case 1:
            return moviesArray.count
        default:
            return moviesArray.count
        }
    
    }
  
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 169
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view=UIView()
        view.backgroundColor=UIColor.lightGray
        let label=UILabel()
        label.text=tableSections[section]
        label.frame=CGRect(x: 5, y: 5, width: 120, height: 35)
        view.addSubview(label)
        return view
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            if self.tableView(allMoviesTableview, numberOfRowsInSection: section)>0{
                return 50
            }
        case 1:
            if self.tableView(allMoviesTableview, numberOfRowsInSection: section)>0{
                return 50
            }
        default:
            return 0
        }
        
       

      return 0
        
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       
        
        
        
        if indexPath.section  == 1{
        if indexPath.row == moviesArray.count - 1 { //
            
            print("indexPath\(indexPath.row)")
            print("moviesArray.count \(moviesArray.count-1)")
            
//
            if pageNo < totalPages {
                
                let spinner = UIActivityIndicatorView(style: .gray)
                spinner.startAnimating()
                spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
                
                self.allMoviesTableview.tableFooterView = spinner
                self.allMoviesTableview.tableFooterView?.isHidden = false
                
                
                print("fetch new \(pageNo)")
                pageNo += 1
                getData(pageNo: pageNo)
           }
       }
    }

        
        
    }
}

