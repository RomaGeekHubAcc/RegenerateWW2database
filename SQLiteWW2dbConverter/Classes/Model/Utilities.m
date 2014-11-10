//
//  Utilities.m
//  SQLiteWW2dbConverter
//
//  Created by Roman Rybachenko on 10/31/14.
//  Copyright (c) 2014 Roman Rybachenko. All rights reserved.
//

#import "PrefixHeader.pch"

#import "Utilities.h"

@implementation Utilities


+(NSString *) replacePathExtentionTo:(NSString *)pathExtention forString:(NSString *)string {
    string = [string stringByDeletingPathExtension];
    string = [string stringByAppendingPathExtension:pathExtention];
    
    return string;
}


+(NSString *) getPathForFolder:(NSString *)folderName {
    NSString *documentsDirectoryPath = [self getPathToDocumentsDirectory];
    NSString *pathToFolder = [documentsDirectoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@", folderName]];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:pathToFolder]) {
        NSError *error = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:pathToFolder
                                  withIntermediateDirectories:NO
                                                   attributes:nil
                                                        error:&error];
        
        if (error) {
            $l(@"Creating folder error -> %@", [error localizedDescription]);
        }
    }
    
    return pathToFolder;
}


+(NSString *)getPathToDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}


@end
