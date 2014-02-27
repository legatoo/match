//
//  inbox.h
//  test2
//
//  Created by Luo Feiheng on 15/11/13.
//  Copyright (c) 2013 Luo Feiheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface inbox : UITableViewController
@property (strong, nonatomic) IBOutlet UITableView *tableView2;
@property (strong, nonatomic) NSArray *inboxUser;
- (IBAction)showMenu;
@end
