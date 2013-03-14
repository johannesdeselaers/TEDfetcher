//
//  TEDFetcher.m
//  TEDFetcher
//
//  Created by Johannes Deselaers on 9/12/12.
//
//  A class to import JSON data from the TED API
//

#import "TEDFetcher.h"

@implementation TEDFetcher

+ (NSDictionary *)executeTEDFetch:(NSString *)query
{
    query = [NSString stringWithFormat:@"%@&api-key=%@", query, TEDAPIKey];
    query = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //NSLog(@"[%@ %@] sent %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), query);
    
    NSData *jsonData = [[NSString stringWithContentsOfURL:[NSURL URLWithString:query] encoding:NSUTF8StringEncoding error:nil] dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *results = jsonData ? [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&error] : nil;
    if (error) NSLog(@"[%@ %@] JSON error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error.localizedDescription);
        //NSLog(@"[%@ %@] received %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), results);
    
        //NSLog([results description]);
        //NSLog([[[results objectForKey:@"tedx_events"] objectAtIndex:2] description]);
        //NSLog([[[[results objectForKey:@"tedx_events"] objectAtIndex:2] valueForKeyPath:@"tedx_event.ends_at"] description]);

    return results;
}

+ (NSArray *)getTedxgroupsFromID:(int)fromId toID:(int)toId;
{
    int limit = toId - fromId;
    NSString *request = [NSString stringWithFormat:@"https://api.ted.com/v1/tedx_groups.json?filter=id:%d..%d&limit=%d", fromId, toId, limit];
    NSArray *tedxgroups = [[self executeTEDFetch:request] objectForKey:@"tedx_groups"];
        //NSLog([events description]);
    return tedxgroups;
}

+ (NSArray *)getTedxeventsFromID:(int)fromId toID:(int)toId;
{
    int limit = toId - fromId;
    NSString *request = [NSString stringWithFormat:@"https://api.ted.com/v1/tedx_events.json?filter=id:%d..%d&limit=%d", fromId, toId, limit];
    NSArray *tedxevents = [[self executeTEDFetch:request] objectForKey:@"tedx_events"];
        //NSLog([events description]);
    return tedxevents;
}

+(NSArray *)getAllTedxgroups{
    NSString *request = [NSString stringWithFormat:@"https://api.ted.com/v1/tedx_groups.json?&limit=0"];
    NSArray *tedxgroups = [[self executeTEDFetch:request] objectForKey:@"tedx_groups"];
    return tedxgroups;
}

+(NSArray *)getAllTedxevents{
    NSString *request = [NSString stringWithFormat:@"https://api.ted.com/v1/tedx_events.json?&limit=0"];
    NSArray *tedxevents = [[self executeTEDFetch:request] objectForKey:@"tedx_events"];
    return tedxevents;
}

@end