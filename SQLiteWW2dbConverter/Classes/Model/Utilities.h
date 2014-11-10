//
//  Utilities.h
//  SQLiteWW2dbConverter
//
//  Created by Roman Rybachenko on 10/31/14.
//  Copyright (c) 2014 Roman Rybachenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utilities : NSObject

+(NSString *) replacePathExtentionTo:(NSString *)pathExtention forString:(NSString *)string;
+(NSString *)getPathToDocumentsDirectory;
+(NSString *) getPathForFolder:(NSString *)folderName;

@end
