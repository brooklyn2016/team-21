//
//  ChildDetailViewController.h
//  untitled
//
//  Created by Benjamin Yi on 10/28/16.
//  Copyright © 2016 team21. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ChildDetailViewController : UIViewController <AVAudioRecorderDelegate, AVAudioPlayerDelegate>

@property (nonatomic, strong) NSDictionary *childInfo;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UIButton *recordButton;

@end
