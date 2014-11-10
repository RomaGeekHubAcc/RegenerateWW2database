//
//  DateFormatterManager.m
//  DataBaseConvertor
//
//  Created by Roman Rybachenko on 8/19/14.
//  Copyright (c) 2014 Igor Karpenko. All rights reserved.
//

#import "DateFormatterManager.h"

@implementation DateFormatterManager

#pragma mark Static methods

+(NSDateFormatter *) sharedInstance {
    static NSDateFormatter *staticDateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        staticDateFormatter = [NSDateFormatter new];
        NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
        [staticDateFormatter setLocale:usLocale];
        staticDateFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    });
    
    return staticDateFormatter;
}


#pragma mark Instance initialization

+(NSDate*) dateFromString:(NSString*)string withFormat:(NSString*)format {
    [[DateFormatterManager sharedInstance] setDateFormat:format];
    
//    NSRange milisecRange = [string rangeOfString:@"."];
//    if (milisecRange.location) {
//        string = [string substringToIndex:string.length - 3];
//    } else {
//        $l(@" !!!!  dateStr - > %@", string);
//    }
    
    NSDate *date = [[DateFormatterManager sharedInstance] dateFromString:string];
    return date;
}

+(NSString*) stringFromDate:(NSDate*)date withFormat:(NSString*)dateFormat {
    [[DateFormatterManager sharedInstance] setDateFormat:dateFormat];
    return [[DateFormatterManager sharedInstance] stringFromDate:date];
}

@end
