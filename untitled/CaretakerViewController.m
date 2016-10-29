//
//  CaretakerViewController.m
//  untitled
//
//  Created by Benjamin Yi on 10/29/16.
//  Copyright © 2016 team21. All rights reserved.
//

#import "CaretakerViewController.h"

@implementation CaretakerViewController

- (IBAction)finishRegistration:(id)sender {
    [self performSegueWithIdentifier:@"PushSegue" sender:self.nextButton];
}

- (void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
}

@end
