//
//  SecretDetailView.swift
//  Illuminati
//
//  Created by Gosha Arinich on 7/20/14.
//  Copyright (c) 2014 Gosha Arinich. All rights reserved.
//

import UIKit
import QuartzCore

class SecretDetailView: UIView {
    
    lazy var secretView: SecretView = {
        let a = UIScreen.mainScreen().bounds.width
        let view = SecretView(frame: CGRect(x: 0, y: 0, width: a, height: a))
        return view
    }()
    
    lazy var tableView = UITableView().noMask()
    lazy var commentField = UITextField()
        .withPlaceholder("Write a comment (anonymous)...")
        .withFont("AvenirNextCondensed-Regular", ofSize: 16)
        .noMask()
    
    lazy var postButton: UIButton = {
        let button = UIButton.buttonWithType(.System).noMask() as UIButton
        button.titleLabel.font = UIFont(name: "AvenirNextCondensed-Regular", size: 16)
        button.setTitle("Post", forState: .Normal)
        return button
    }()
    
    lazy var bottomView = UIView(frame: CGRectZero).noMask()
        .addTopBorder(UIScreen.mainScreen().bounds.width, height: 1, color: UIColor.lightGrayColor())
        .noMask()
    
    lazy var keyboardHeight: NSLayoutConstraint = {
        return NSLayoutConstraint(item: self.bottomView, attribute: .Bottom, relatedBy: .Equal,
                                  toItem: self, attribute: .Bottom, multiplier: 1, constant: 0)
    }()

    init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(secretView)
        addSubview(tableView)
        addSubview(bottomView)
        bottomView.addSubview(commentField)
        bottomView.addSubview(postButton)
        
//        tableView.separatorStyle = .None
//        tableView.alwaysBounceVertical = false
//        tableView.tableHeaderView = secretView
    }
    
    override class func requiresConstraintBasedLayout() -> Bool {
        return true
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        let views = [
            "secret": secretView,
            "table": tableView,
            "bottom": bottomView,
            "comment": commentField,
            "post": postButton
        ]

        addConstraints("|[secret]|" %%% (nil, nil, views))
        addConstraints("|[table]|" %%% (nil, nil, views))
        addConstraints("|[bottom]|" %%% (nil, nil, views))
        addConstraints("V:|[secret][table][bottom(40)]" %%% (nil, nil, views))
        
        bottomView.addConstraints("|-[comment]-[post]-|" %%% (nil, nil, views))
        bottomView.addConstraints("V:|[comment]|" %%% (nil, nil, views))
        
        bottomView.addConstraint(NSLayoutConstraint(item: postButton, attribute: .CenterY, relatedBy: .Equal, toItem: commentField, attribute: .CenterY, multiplier: 1, constant: 0))

        
        addConstraint(keyboardHeight)
    }

}
