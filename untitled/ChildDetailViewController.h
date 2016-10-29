//
//  ChildDetailViewController.h
//  untitled
//
//  Created by Benjamin Yi on 10/28/16.
//  Copyright © 2016 team21. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChildDetailViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) NSMutableArray *childInfo;
@property (nonatomic, strong) IBOutlet UIButton *backButton;

@end
