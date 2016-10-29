//
//  CaretakerViewController.m
//  untitled
//
//  Created by Benjamin Yi on 10/29/16.
//  Copyright © 2016 team21. All rights reserved.
//

#import "CaretakerViewController.h"

@implementation CaretakerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
}

- (void)setupNavigationBar {
    self.navigationItem.title = @"Caretaker Registration";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (IBAction)finishRegistration:(id)sender {
    [self performSegueWithIdentifier:@"PushSegue" sender:self.nextButton];
}

- (IBAction)takePhoto:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)selectPhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    [self.cameraButton setBackgroundImage:chosenImage forState:UIControlStateNormal];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
}

@end
