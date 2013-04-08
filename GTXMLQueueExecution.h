//
//  GTXMLQueueExecution.h
//  GCDQueuesURLRequest
//
//  Created by User on 08/04/2013.
//  Copyright (c) 2013 amaCoder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GTXMLQueueExecution : NSObject<NSXMLParserDelegate>

-(void)performConnectionWithString:(NSString *) urlString;
-(void)performMajorExecution;
@end
