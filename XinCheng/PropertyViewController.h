//
//  PropertyViewController.h
//  XinCheng
//
//  Created by wmm on 15/11/10.
//  Copyright © 2015年 hanen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IRevealControllerProperty.h"

@interface PropertyViewController : UIViewController<IRevealControllerProperty,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

- (IBAction)sideLeftButton_selector:(id)sender;

@end
