//
//  ModalWordRetriever.m
//  untitled
//
//  Created by Benjamin Yi on 10/29/16.
//  Copyright © 2016 team21. All rights reserved.
//

#import "ModalWordRetriever.h"

@implementation ModalWordRetriever

- (void)viewDidLoad {
    self.addButton.layer.borderColor = self.view.tintColor.CGColor;
    self.addButton.layer.cornerRadius = 4.0;
    self.addButton.layer.masksToBounds = YES;
    self.addButton.layer.borderWidth = 1.0;
    self.addButton.enabled = NO;
    //    url_string = [NSString stringWithFormat:@"%@/meaning", ROOT_URL];
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    NSDictionary *new = @{@"name" : @"test_name", @"audio" :@"test_audio", @"meaning" :@{}};
    //
    //    [manager POST:url_string parameters:new progress:nil success:^(NSURLSessionTask *task, id responseObject) {
    //        NSLog(@"%@", responseObject);
    //        }failure:^(NSURLSessionTask *operation, NSError *error) {
    //        NSLog(@"Error: %@",error);
    //    }];
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
    
}

- (IBAction)popModal:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
