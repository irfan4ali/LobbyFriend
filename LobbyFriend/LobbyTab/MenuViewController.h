//
//  MenuViewController.h
//  LobbyFriend
//
//  Created by Imran on 07/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIBarButtonItem *settingBarButton;
@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) IBOutlet UITableView *settingTable;
@property (strong, nonatomic) IBOutlet UITableViewCell *settingTableCell;

@end
