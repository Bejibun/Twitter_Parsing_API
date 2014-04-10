//
//  ViewController.m
//  XML_Parsing
//
//  Created by Frans Kurniawan on 4/9/14.
//  Copyright (c) 2014 Frans Kurniawan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong,nonatomic)NSArray *twitterFeed;

@end

@implementation ViewController
@synthesize tblView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//
//-(void)twitterTimeLine
//{
//    ACAccountStore *account = [[ACAccountStore alloc]init];
//    
//    ACAccountType *accountType = [account accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
//
//    [account requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
//        if(granted == YES)
//        {
//            NSArray *arrayOfAccounts = [account accountsWithAccountType:accountType];
//            if ([arrayOfAccounts count] > 0) {
//                ACAccount *twitterAccount = [arrayOfAccounts lastObject];
//                NSURL *requestAPI = [NSURL URLWithString:@"any xml Link"];
//                NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
//                
//                [parameters setObject:@"100" forKey:@"count"];
//                [parameters setObject:@"1" forKey:@"include_entities"];
//                SLRequest *posts = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:requestAPI parameters:parameters];
//                
//                posts.account = twitterAccount;
//                
//                [posts performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
//                    self.array = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
//                    if(self.array.count != 0)
//                    {
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            [tblView reloadData];
//                        });
//                    }
//                }];
//                
//            }
//        }
//        else
//        {
//            NSLog(@"%@", [error localizedDescription]);
//        }
//    }];
//}



//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return [[xmlParser tweets]count];
//}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if(cell == nil)
//    {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
//    }
//    Tweet *currentTweet = [[xmlParser tweets]objectAtIndex:indexPath.row];
//    
//    CGRect contentFrame = CGRectMake(45,2,265,30);
//    UILabel *contentLabel = [[UILabel alloc]initWithFrame:contentFrame];
//    contentLabel.numberOfLines = 2;
//    contentLabel.font = [UIFont boldSystemFontOfSize:12];
//    contentLabel.text = [currentTweet content];
//    [cell.contentView addSubview:contentLabel];
//    
//    CGRect dateFrame = CGRectMake(45, 40, 265, 10);
//    UILabel *dateLabel = [[UILabel alloc]initWithFrame:dateFrame];
//    dateLabel.font = [UIFont systemFontOfSize:10];
//    dateLabel.text = [currentTweet dataCreated];
//    [cell.contentView addSubview:dateLabel];
//    
//    return cell;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 55;
//}

- (void)viewDidLoad
{

    xmlParser = [[XMLParser alloc]loadXMLByURL:@"http://api.twitter.com/1.1/statuses/user_timeline/KentFranks.xml"];
        [super viewDidLoad];
    self.title = @"Frans' Twitter";
    
    STTwitterAPI *twitter = [STTwitterAPI twitterAPIAppOnlyWithConsumerKey:@"em4QLRj66S9ozDwq1C2TMA" consumerSecret:@"iIT4ymnB1GX7k999Ok3gUs4zJsxw5VnVlJqdg9q8qw"];
    
    [twitter verifyCredentialsWithSuccessBlock:^(NSString *username) {
        [twitter getUserTimelineWithScreenName:@"bejibun" successBlock:^(NSArray *statuses) {
            
            self.twitterFeed = [NSMutableArray arrayWithArray:statuses];
            [tblView reloadData];
            
        } errorBlock:^(NSError *error) {
            NSLog(@"%@", error.debugDescription);
        }];
    } errorBlock:^(NSError *error) {
        NSLog(@"%@", error.debugDescription);
    }];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark Table View Data Source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.twitterFeed.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    NSInteger idx = indexPath.row;
    NSDictionary *t = self.twitterFeed[idx];
    cell.textLabel.text = t[@"text"];
    cell.textLabel.numberOfLines = 5;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:12];
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
