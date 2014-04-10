//
//  XMLParser.m
//  XML_Parsing
//
//  Created by Frans Kurniawan on 4/9/14.
//  Copyright (c) 2014 Frans Kurniawan. All rights reserved.
//

#import "XMLParser.h"
#import "Tweet.h"

@implementation XMLParser
@synthesize tweets;

-(id)loadXMLByURL:(NSString *)urlString
{
    tweets = [[NSMutableArray alloc]init];
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [[NSData alloc]initWithContentsOfURL:url];
    parser = [[NSXMLParser alloc]initWithData:data];
    parser.delegate = self;
    [parser parse];
    return self;
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"status"])
    {
        currentTweet = [Tweet alloc];
        isStatus = YES;
    }
    if ([elementName isEqualToString:@"user"]) {
        isStatus = NO;
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (isStatus) {
        if([elementName isEqualToString:@"created_at"])
        {
            currentTweet.dataCreated = currentNodeContent;
        }
        if([elementName isEqualToString:@"text"])
        {
            currentTweet.content = currentNodeContent;
        }
    }
    if([elementName isEqualToString:@"status"])
    {
        [tweets addObject:currentTweet];
        currentTweet = nil;
        currentNodeContent = nil;
        
    }
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    currentNodeContent = (NSMutableString *) [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
