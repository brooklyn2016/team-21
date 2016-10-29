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
