//
//  ChildDetailViewController.m
//  untitled
//
//  Created by Benjamin Yi on 10/28/16.
//  Copyright © 2016 team21. All rights reserved.
//

#import "ChildDetailViewController.h"
#import "ModalWordRetriever.h"

@interface ChildDetailViewController ()

@property (nonatomic, strong) AVAudioRecorder *recorder;
@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, assign) BOOL readyToModal;
@property (nonatomic, strong) ModalWordRetriever *wordRetrieverVC;
@end

@implementation ChildDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    _readyToModal = NO;
    self.navigationItem.title = self.childInfo[@"name"];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.childInfo[@"img"]]];
        dispatch_async(dispatch_get_main_queue(), ^(void){
            self.imageView.image = [UIImage imageWithData:imageData];
        });
    });
    
    // Set the audio file
    NSArray *pathComponents = [NSArray arrayWithObjects:
                               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],
                               @"MyAudioMemo.m4a",
                               nil];
    NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
    
    // Setup audio session
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    // Define the recorder setting
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
    
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
    
    // Initiate and prepare the recorder
    _recorder = [[AVAudioRecorder alloc] initWithURL:outputFileURL settings:recordSetting error:NULL];
    _recorder.delegate = self;
    _recorder.meteringEnabled = YES;
    [_recorder prepareToRecord];
    
    [session setActive:YES error:nil];
    [_recorder record];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)recordStop:(id)sender {
    if (_player.playing) {
    }
    
    if (!_recorder.recording) {
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        
        // Start recording
        [_recorder record];
        
    } else {
        [_recorder stop];
        
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:_recorder.url error:nil];
        _readyToModal = YES;
        
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            
            dispatch_async(dispatch_get_main_queue(), ^(void){
                [self performSegueWithIdentifier:@"ModalSegue" sender:self];
    
            });
        });
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ModalSegue"]) {
        _wordRetrieverVC = (ModalWordRetriever *)segue.destinationViewController;
        _wordRetrieverVC.player = _player;
        _wordRetrieverVC.recorder = _recorder;
        _wordRetrieverVC.childInfo = _childInfo;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
