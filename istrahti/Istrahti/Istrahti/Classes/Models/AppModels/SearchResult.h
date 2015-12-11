//
//  SearchResult.h
//  Istrahti
//
//  Created by Ahmed Askar on 8/28/15.
//  Copyright (c) 2015 Ahmed Askar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBJSONModel.h"
#import "SearchData.h"

@interface SearchResult : MBJSONModel

@property (nonatomic ,strong) NSArray *Data ;
@property (nonatomic ,assign) BOOL Error;
@property (nonatomic ,strong) NSString *Message ;

@end
