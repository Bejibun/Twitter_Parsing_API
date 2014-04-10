//
//  XMLParser.h
//  XML_Parsing
//
//  Created by Frans Kurniawan on 4/9/14.
//  Copyright (c) 2014 Frans Kurniawan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tweet.h"

@interface XMLParser : NSObject<NSXMLParserDelegate>
{
    NSMutableString *currentNodeContent;
    NSMutableArray *tweets;
    NSXMLParser *parser;
    BOOL isStatus;
    Tweet *currentTweet;
}

@property(strong,readonly)NSMutableArray *tweets;

-(id)loadXMLByURL:(NSString *)urlString;

@end
