//
//  SLType.h
//  Parallaxer
//
//  Created by s.leluk on 17.09.12.
//  Copyright 2012 Mozi Development. All rights reserved.
//

#import "PrefixHeader.pch"

#import "SLContentType.h"


@interface SLType : NSObject 

@property (nonatomic, assign) NSInteger typeId;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, assign) NSInteger contenTypeId;

@property (nonatomic, assign) NSInteger zeditoriconnum;

@property (nonatomic, retain) SLContentType *contentType;

@end
