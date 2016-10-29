//
//  ModalWordRetriever.m
//  untitled
//
//  Created by Benjamin Yi on 10/29/16.
//  Copyright © 2016 team21. All rights reserved.
//

#import "ModalWordRetriever.h"
#import <AFNetworking/AFHTTPSessionManager.h>

static NSString *ROOT_URL = @"http://ec2-107-20-15-98.compute-1.amazonaws.com:5000";

@implementation ModalWordRetriever

- (void)viewDidLoad {
    self.addButton.layer.borderColor = self.view.tintColor.CGColor;
    self.addButton.layer.cornerRadius = 4.0;
    self.addButton.layer.masksToBounds = YES;
    self.addButton.layer.borderWidth = 1.0;
    self.addButton.enabled = NO;
    
    NSData *audioData = [NSData dataWithContentsOfURL:_recorder.url];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *url_string = [NSString stringWithFormat:@"%@/meaning", ROOT_URL];
    
    
    id params = @{ @"name":self.childInfo[@"name"], @"audio":audioData };
    
    [manager GET:url_string parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        self.topLabel.text = @"Is this your letter?";
        self.meaningLabel.text = responseObject[@"meaning"];
    }failure:^(NSURLSessionTask *operation, NSError *error) {
        
        NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSLog(@"\n\n\n\n%@\n\n\n\n\n\n",errResponse);
        //NSLog(@"%@", operation.response);
        self.topLabel.text = @"Could not understand...";
        self.meaningLabel.text = @"Click below to add to the dictionary!";
        self.addButton.enabled = YES;
    }];
}

- (IBAction)playStop:(id)sender {
    if (!_player.playing) {
        [_player play];
        [self.playButton setBackgroundImage:[UIImage imageNamed:@"stop_button2"] forState:UIControlStateNormal];
    } else {
        [_player stop];
        _player.currentTime = 0;
        [self.playButton setBackgroundImage:[UIImage imageNamed:@"play_button"] forState:UIControlStateNormal];
    }
}

- (IBAction)addWord:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Processing..." message:@"Attempting to add word..." preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url_string = [NSString stringWithFormat:@"%@/meaning", ROOT_URL];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    id params = @{@"name": self.childInfo[@"name"]};

    [manager POST:url_string parameters:new progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            
            dispatch_async(dispatch_get_main_queue(), ^(void){
                alert.message = @"Successfully added!";
                alert.title = @"Done!";
            });
        });
    }failure:^(NSURLSessionTask *operation, NSError *error) {
        alert.message = @"There seems to be a server error...";
        alert.title = @"Oops!";
    }];
    
    
}

- (IBAction)popModal:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
