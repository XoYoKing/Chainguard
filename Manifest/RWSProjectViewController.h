//
//  RWProjectViewController.h
//  Manifest
//
//  Created by Samuel Goodwin on 27-01-14.
//  Copyright (c) 2014 Roundwall Software. All rights reserved.
//

#import "RWSProject.h"
#import "RWSNewItemViewController.h"

@interface RWSProjectViewController : UITableViewController<UITextFieldDelegate, RWSNewItemDelegate>
@property (nonatomic, strong) id<RWSProject> project;
@end
