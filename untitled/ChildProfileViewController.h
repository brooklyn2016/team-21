//
//  ChildProfileViewController.h
//  untitled
//
//  Created by Benjamin Yi on 10/29/16.
//  Copyright © 2016 team21. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChildProfileViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) IBOutlet UIButton *cameraButton;
@property (nonatomic, strong) IBOutlet UIButton *addButton;
@property (nonatomic, strong) IBOutlet UITextField *nameTextField;
@property (nonatomic, strong) IBOutlet UITextField *ageTextField;
@property (nonatomic, strong) IBOutlet UITextField *prefTextField;

@end
