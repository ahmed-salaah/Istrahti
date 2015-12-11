//
//  SmallIconsModel.h
//  Istrahti
//
//  Created by Ahmed Askar on 8/29/15.
//  Copyright (c) 2015 Ahmed Askar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SmallIconsModel : NSObject

@property (nonatomic ,strong) NSString *imageName ;
@property (nonatomic ,strong) NSString *name ;

- (instancetype)initWithName:(NSString *)name andImage:(NSString *)imgName ;

@end