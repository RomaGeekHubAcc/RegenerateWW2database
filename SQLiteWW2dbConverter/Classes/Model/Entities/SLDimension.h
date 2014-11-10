//
//  SLDimension.h
//  Parallaxer
//
//  Created by s.leluk on 17.09.12.
//  Copyright 2012 Mozi Development. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SLDimension : NSObject 

@property (nonatomic, assign) NSInteger dimensionId;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, assign) BOOL isFilter;
@property (nonatomic, assign) NSInteger color;
@property (nonatomic, retain) NSArray *tags;

@end
