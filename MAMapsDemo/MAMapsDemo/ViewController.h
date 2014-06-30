//
//  ViewController.h
//  MAMapsDemo
//
//  Created by Paul Napier on 30/06/2014.
//  Copyright (c) 2014 madapper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    UITableView *tv;
    NSArray *views;
}

@end
