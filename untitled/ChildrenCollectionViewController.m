//
//  ChildrenTableViewController.m
//  untitled
//
//  Created by Benjamin Yi on 10/28/16.
//  Copyright © 2016 team21. All rights reserved.
//

#import "ChildrenCollectionViewController.h"
#import "ChildDetailViewController.h"
#import "ChildrenCollectionViewCell.h"
#import <AFNetworking/AFHTTPSessionManager.h>

static NSString *ROOT_URL = @"http://ec2-107-20-15-98.compute-1.amazonaws.com:5000";

@interface ChildrenCollectionViewController ()

@property (nonatomic, strong) NSMutableArray *children;

@end

@implementation ChildrenCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.children = [NSMutableArray array];
    self.collectionView.backgroundColor = [UIColor grayColor];

    [self getChildrenRoster];
}

- (void)getChildrenRoster {
    NSString *url_string = [NSString stringWithFormat:@"%@/getRoster", ROOT_URL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:url_string parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            for(NSArray *child in (NSDictionary *)responseObject[@"data"]) {
                [self.children addObject:child];
            }
            dispatch_async(dispatch_get_main_queue(), ^(void){
                [self.collectionView reloadData];
            });
        });
    }failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@",error);
    }];
    
//    url_string = [NSString stringWithFormat:@"%@/meaning", ROOT_URL];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    NSDictionary *new = @{@"name" : @"test_name", @"audio" :@"test_audio"};
//    
//    [manager POST:url_string parameters:new progress:nil success:^(NSURLSessionTask *task, id responseObject) {
//        NSLog(@"%@", responseObject);
//        }failure:^(NSURLSessionTask *operation, NSError *error) {
//        NSLog(@"Error: %@",error);
//    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Collection view data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.children.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"infoCell";
    ChildrenCollectionViewCell *cell = (ChildrenCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];

    cell.nameLabel.text = self.children[indexPath.row][@"name"];
    cell.nameLabel.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.3];
    cell.nameLabel.textColor = [UIColor whiteColor];
    cell.layer.borderWidth = 1;
    cell.backgroundColor = [UIColor lightGrayColor];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.children[indexPath.row][@"img"]]];
        dispatch_async(dispatch_get_main_queue(), ^(void){
            cell.imageView.image = [UIImage imageWithData:imageData];
        });
    });
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"DetailSegue" sender:_children[indexPath.row]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"DetailSegue"]) {
        ChildDetailViewController *detailVC = (ChildDetailViewController *)segue.destinationViewController;
        detailVC.childInfo =  (NSMutableArray *)sender;
    }
}

#pragma mark - Collection view flow layout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.frame.size.width/2, self.view.frame.size.width/2);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*) collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*) collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
