//
//  Protocols.swift
//  CaseStudy-BilalYalcin
//
//  Created by Bilal Yalcin on 14.11.2022.
//

import Foundation
import UIKit

protocol NetworkActivityIndicatorPresentable {}

extension NetworkActivityIndicatorPresentable where Self: UIViewController {
    
    var tag : Int {
        111
    }
    
    private var activityIndicatorView : UIActivityIndicatorView {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.color = .white
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }
    
    private var transparentView : UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        view.tag = tag
        
        let activityIndicatorView = self.activityIndicatorView
        view.addSubview(activityIndicatorView)
        activityIndicatorView.center = view.center
        
        return view
    }
    
    func showNetworkActivityIndicator(){
        view.addSubview(transparentView)
    }
    
    func hideNetworkActivityIndicator(){
        view.subviews.forEach { view in
            if view.tag == tag {
                view.removeFromSuperview()
            }
        }
    }
}
