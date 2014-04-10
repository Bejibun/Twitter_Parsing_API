//
//  ViewController.h
//  XML_Parsing
//
//  Created by Frans Kurniawan on 4/9/14.
//  Copyright (c) 2014 Frans Kurniawan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLParser.h"
#import "Tweet.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import "STTwitter.h"

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    XMLParser *xmlParser;
}
@property (strong, nonatomic) IBOutlet UITableView *tblView;

@end
