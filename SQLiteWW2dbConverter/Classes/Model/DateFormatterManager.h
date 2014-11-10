//
//  DateFormatterManager.h
//  DataBaseConvertor
//
//  Created by Roman Rybachenko on 8/19/14.
//  Copyright (c) 2014 Igor Karpenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateFormatterManager : NSObject

+(NSDateFormatter *) sharedInstance;

+(NSDate*) dateFromString:(NSString*)string withFormat:(NSString*)format;
+(NSString*) stringFromDate:(NSDate*)date withFormat:(NSString*)dateFormat;

@end
