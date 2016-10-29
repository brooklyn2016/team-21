//
//  ModalWordRetriever.m
//  untitled
//
//  Created by Benjamin Yi on 10/29/16.
//  Copyright © 2016 team21. All rights reserved.
//

#import "ModalWordRetriever.h"

@implementation ModalWordRetriever

- (IBAction)playStop:(id)sender {
    if (!_player.playing) {
        [_player play];
        [self.playButton setBackgroundImage:[UIImage imageNamed:@"stop_button2"] forState:UIControlStateNormal];
        NSLog(@"playing...");
    } else {
        [_player stop];
        _player.currentTime = 0;
        NSLog(@"stopping.....");
        [self.playButton setBackgroundImage:[UIImage imageNamed:@"play_button"] forState:UIControlStateNormal];
    }
}

@end
