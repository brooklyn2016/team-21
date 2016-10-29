//
//  ModalWordRetriever.h
//  untitled
//
//  Created by Benjamin Yi on 10/29/16.
//  Copyright © 2016 team21. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ChildDetailViewController.h"

@interface ModalWordRetriever : UIViewController <AVAudioPlayerDelegate>

@property (nonatomic, strong) IBOutlet UIButton *playButton;
@property (nonatomic, strong) UILabel *meaningLabel;
@property (nonatomic, strong) UIButton *addWordButton;
@property (nonatomic, strong) AVAudioPlayer *player;

@end
