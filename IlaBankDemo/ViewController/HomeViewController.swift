//
//  HomeViewController.swift
//  IlaBankDemo
//
//  Created by Neosoft on 28/12/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    static let HOME_CELL = "homeCell"
    
    var arrImages = [ImageItem]()
    lazy var viewModel = HomeViewModel()
    lazy var searchBar = UISearchBar()

    //MARK: - ####### VIEW BINDING #######
    @IBOutlet weak var imageTableView: UITableView!
    
    
    
    //MARK: - ####### VIEW DELEGATE #######
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateTableUI()
    }
    
    private func updateTableUI(){
        self.viewModel.imageData.bind { arrImages in
            self.arrImages = arrImages
            self.imageTableView.reloadData()
        }
        
        self.viewModel.arrImageItems.bind { _ in
            self.imageTableView.reloadData()
        }
        
        self.viewModel.selectedImage.bind { _ in
            self.searchBar.text = ""
            self.view.endEditing(true)
            self.viewModel.filterCurrentData(searchText: "")
        }
        
        if #available(iOS 15.0, *) {
            self.imageTableView.sectionHeaderTopPadding = 0
        }
    }


}

//MARK: - ####### TABLE VIEW DELEGATE / DATA SOURCE #######

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 0 : self.viewModel.arrImageItems.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewController.HOME_CELL, for: indexPath)
        
        let itemObj           = self.viewModel.arrImageItems.value[indexPath.row]
        cell.textLabel?.text  = itemObj.title
        cell.imageView?.image = itemObj.imageName == "" ? .checkmark : UIImage.init(systemName:itemObj.imageName ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //** GET SEARCH BAR **
        if section == 1 {
            let responseView        = self.viewModel.getSearchBar(width: self.view.bounds.width)
            responseView.0.delegate = self
            self.searchBar          = responseView.0
            return responseView.1
        }
        // ** GET IMAGE SCROLL VIEW **
        let responseView        = self.viewModel.getImageScrollView(width: self.view.bounds.width)
        responseView.0.delegate = self
        return responseView.1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 300 : 60
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

//MARK: - ####### SCROLLVIEW DELEGATE #######

extension HomeViewController: UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.tag != 1001 {return}
        let x = scrollView.contentOffset.x
        let w = scrollView.bounds.size.width
        self.viewModel.pageIndicator.value.currentPage = Int(ceil(x/w))
        self.viewModel.selectedImage.value = Int(ceil(x/w))
    }
}

//MARK: - ####### SEARCH BAR DELEGATE #######

extension HomeViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.filterCurrentData(searchText: searchText)
    }
}
