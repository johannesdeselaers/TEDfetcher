//
//  TEDFetcher.h
//  TEDFetcher
//
//  Created by Johannes Deselaers on 9/12/12.
//
//  A class to import JSON data from the TED API
//

#import <Foundation/Foundation.h>

#define TEDAPIKey @"YourKeyHere"

#define TED_EVENT_TITLE @"title"

@interface TEDFetcher : NSObject

+ (NSArray *)getTedxgroupsFromID:(int)fromId toID:(int)toId; // toId - fromId must be less than 100!
+ (NSArray *)getTedxeventsFromID:(int)fromId toID:(int)toId; // toId - fromId must be less than 100!

+ (NSArray *)getAllTedxgroups;
+ (NSArray *)getAllTedxevents;

@end
