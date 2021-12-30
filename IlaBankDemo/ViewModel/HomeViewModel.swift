//
//  HomeViewModel.swift
//  IlaBankDemo
//
//  Created by Neosoft on 28/12/21.
//

import UIKit

class HomeViewModel: NSObject {
    
    private(set) var imageData     = Observable<[ImageItem]>([])
    private(set) var selectedImage = Observable<Int>(0)
    private(set) var pageIndicator = Observable<UIPageControl>(UIPageControl.init())
    private(set) var arrImageItems = Observable<[Items]>([])

    
    override init() {
        super.init()
        
        self.fetchData()
    }
    
    //MARK: - ####### SWIPABLE IMAGEVIEW #######
    
    func getImageScrollView(width: CGFloat) -> (UIScrollView,UIView){
        let height        = 300.0
        let frameObj      = CGRect.init(x: 0, y: 0, width: width, height: height)
        let viewContainer = UIView.init(frame: frameObj)
        let scrollView    = UIScrollView.init(frame: frameObj)
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.tag = 1001
        
        for i in 0..<imageData.value.count {
            let imageObj = imageData.value[i]
            let offset   = i == 0 ? 0 : (CGFloat(i) * scrollView.bounds.width)
            let imgView  = UIImageView(frame: CGRect(x: offset, y: 0, width: scrollView.bounds.width, height: height))
            
            imgView.image         = UIImage.init(named: imageObj.imageName ?? "")
            imgView.clipsToBounds = true
            scrollView.addSubview(imgView)
        }
        
        pageIndicator.value = UIPageControl.init(frame: CGRect.init(x: 0, y: height-30, width: width, height: 30))
        pageIndicator.value.numberOfPages   = imageData.value.count
        pageIndicator.value.backgroundStyle = .prominent
        pageIndicator.value.currentPage     = self.selectedImage.value

        // set the contentSize
        scrollView.contentSize = CGSize(width: CGFloat(imageData.value.count) * scrollView.bounds.width, height: height)
        
        let offset = self.selectedImage.value == 0 ? 0 : (CGFloat(self.selectedImage.value) * scrollView.bounds.width)
        scrollView.scrollRectToVisible(CGRect(x: offset, y: 0, width: scrollView.bounds.width, height: height), animated: false)
        viewContainer.addSubview(scrollView)
        viewContainer.addSubview(pageIndicator.value)
        return (scrollView, viewContainer)
    }
    
    //MARK: - ####### SEARCH BAR #######

    func getSearchBar(width: CGFloat) -> (UISearchBar, UIView){
        let height        = 60.0
        let frameObj      = CGRect.init(x: 0, y: 0, width: width, height: height)
        let viewContainer = UIView.init(frame: frameObj)
        let searchBar     = UISearchBar.init(frame: CGRect.init(x: 0, y: 0, width: width, height: height))
        
        searchBar.placeholder = "Search"
        viewContainer.addSubview(searchBar)
        return (searchBar, viewContainer)
    }
    
    //MARK: - ####### FETCH DATA #######
    
    private func fetchData() {
        self.addSchoolData()
        self.addOfficeData()
        self.addHouseData()
        self.addCarData()
        self.addCityData()
        self.arrImageItems.value = self.imageData.value[self.selectedImage.value].arrItems ?? []
    }
    
    //MARK: - ####### SCHOOL DATA #######
    
    private func addSchoolData() {
        let item1 = Items.init(imageName: "person.3", title: "Student")
        let item2 = Items.init(imageName: "person", title: "Teacher")
        let item3 = Items.init(imageName: "folder", title: "Black Board")
        let item4 = Items.init(imageName: "studentdesk", title: "Bench")
        let item5 = Items.init(imageName: "clear", title: "Duster")
        let item6 = Items.init(imageName: "book", title: "Book")
        let item7 = Items.init(imageName: "book.fill", title: "Note Book")
        let item8 = Items.init(imageName: "pencil", title: "Pencil")
        let item9 = Items.init(imageName: "paperclip", title: "Paper")
        let item10 = Items.init(imageName: "pencil.tip", title: "Ink Pen")
        let item11 = Items.init(imageName: "pencil", title: "Gel Pen")
        let item12 = Items.init(imageName: "pencil.tip", title: "Ball Pen")
        let item13 = Items.init(imageName: "pencil", title: "Eraser")
        let item14 = Items.init(imageName: "pencil.tip", title: "Scale")
        let item15 = Items.init(imageName: "bag", title: "School Bag")

        let arrCarItems = [item1,item2,item3,item4,item5,item6,item7,item8,item9,item10,item11,item12,item13,item14,item15]
        
        let imageItemCar = ImageItem.init(imageName: "school", arrItems: arrCarItems)
        self.imageData.value.append(imageItemCar)
    }
    
    //MARK: - ####### OFFICE DATA #######
    
    private func addOfficeData() {
        let item1 = Items.init(imageName: "", title: "Work Place")
        let item2 = Items.init(imageName: "", title: "Meeting Room")
        let item3 = Items.init(imageName: "", title: "Desktop")
        let item4 = Items.init(imageName: "", title: "Laptop")
        let item5 = Items.init(imageName: "", title: "Employee")
        let arrCarItems = [item1,item2,item3,item4,item5]
        
        let imageItemCar = ImageItem.init(imageName: "office", arrItems: arrCarItems)
        self.imageData.value.append(imageItemCar)
    }
    
    private func addHouseData() {
        let item1 = Items.init(imageName: "", title: "Bed Room")
        let item2 = Items.init(imageName: "", title: "Kitchen")
        let item3 = Items.init(imageName: "", title: "Window")
        let arrCarItems = [item1,item2,item3]
        
        let imageItemCar = ImageItem.init(imageName: "house", arrItems: arrCarItems)
        self.imageData.value.append(imageItemCar)
    }
    
    private func addCarData() {
        let item1 = Items.init(imageName: "", title: "Door")
        let item2 = Items.init(imageName: "", title: "Tyre")
        let item3 = Items.init(imageName: "", title: "Seat")
        let item4 = Items.init(imageName: "", title: "Glass")
        let item5 = Items.init(imageName: "", title: "Engine")
        let item6 = Items.init(imageName: "", title: "Viper")
        let item7 = Items.init(imageName: "", title: "Central Lock")
        let arrCarItems = [item1,item2,item3,item4,item5,item6,item7]
        
        let imageItemCar = ImageItem.init(imageName: "car", arrItems: arrCarItems)
        self.imageData.value.append(imageItemCar)
    }
    
    private func addCityData() {
        let item1 = Items.init(imageName: "", title: "River View")
        let item2 = Items.init(imageName: "", title: "Lake View")
        let item3 = Items.init(imageName: "", title: "Mountaine")
        let item4 = Items.init(imageName: "", title: "Forest")
        let item5 = Items.init(imageName: "", title: "Highway")
        let arrCarItems = [item1,item2,item3,item4,item5]
        
        let imageItemCar = ImageItem.init(imageName: "city", arrItems: arrCarItems)
        self.imageData.value.append(imageItemCar)
    }
    
    func filterCurrentData(searchText: String) {
        let imageObj        = self.imageData.value[self.selectedImage.value].arrItems
        if searchText == ""{
            arrImageItems.value = imageObj ?? []
        }else {
            arrImageItems.value = imageObj?.filter({$0.title!.contains(searchText)}) ?? []
        }
    }
    
}
