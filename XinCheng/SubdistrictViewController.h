//
//  SubdistrictViewController.h
//  XinCheng
//
//  Created by wmm on 15/11/11.
//  Copyright © 2015年 hanen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IRevealControllerProperty.h"

@interface SubdistrictViewController : UIViewController<IRevealControllerProperty>

@property (nonatomic, assign) NSInteger  role;

- (IBAction)sideLeftButton_selector:(id)sender;

@end
