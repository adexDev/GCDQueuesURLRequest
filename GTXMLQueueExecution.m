//
//  GTXMLQueueExecution.m
//  GCDQueuesURLRequest
//
//  Created by User on 08/04/2013.
//  Copyright (c) 2013 amaCoder. All rights reserved.
//

#import "GTXMLQueueExecution.h"
#import <dispatch/queue.h>

@interface GTXMLQueueExecution (){
    
    dispatch_queue_t xmlQueue;
}

@end

@implementation GTXMLQueueExecution

-(id)init{
    
    self = [super init];
    if (self) {
        
        xmlQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    }
    
    return self;
}

-(void)performConnectionWithString:(NSString *)urlString{
    
  __block  NSURLResponse *response;
  __block  NSError *error;
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
    
    dispatch_async(xmlQueue, ^{
        
        NSData *data = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:&response
                                                         error:&error];
        if (error) {
            
            NSLog(@"%@", error.localizedDescription);
        }
        
        if (response) {
        
        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
        [parser setDelegate:self];
        [parser parse];
            
        }
    });
    
    
}

-(void)performMajorExecution{
    
    NSArray *array = [NSArray arrayWithObjects:@"http://rss.cnn.com/rss/edition.rss", @"http://rss.cnn.com/rss/edition_world.rss", nil];
    
    dispatch_queue_t executionQueue = dispatch_queue_create("com.GCDQueuesURLRequest.executionQueues", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(executionQueue, ^{
        
        for (int i = 0; i < [array count]; i++) {
           
            NSString * string = [array objectAtIndex:i];
            [self performConnectionWithString:string];
                    NSLog(@"COUUNNNNNNTTTT  ===== %d", i); 
           
        }
    });
}



#pragma mark - XMLPARSER DELEGATE

-(void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName
   attributes:(NSDictionary *)attributeDict{
    
    NSLog(@"%@", elementName);
 
    
}


@end
