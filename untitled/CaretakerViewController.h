//
//  CaretakerViewController.h
//  untitled
//
//  Created by Benjamin Yi on 10/29/16.
//  Copyright © 2016 team21. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CaretakerViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) IBOutlet UIButton *cameraButton;
@property (nonatomic, strong) IBOutlet UITextField *nameTextField;
@property (nonatomic, strong) IBOutlet UIButton *nextButton;

@end
