//
//  MDRouterWebsiteAdapter.m
//  MDRouter
//
//  Created by Jave on 2017/12/15.
//  Copyright © 2017年 markejave. All rights reserved.
//

#import "MDRouterWebsiteAdapter.h"
#import "MDRouterAdapter+Private.h"

@interface MDRouterWebsiteAdapter ()

@property (nonatomic, copy) id (^block)(NSDictionary *arguments, NSError **error);

@end

@implementation MDRouterWebsiteAdapter

+ (instancetype)adapterWithBlock:(id (^)(NSDictionary *arguments, NSError **error))block;{
    return [[self alloc] initWithBlock:block];
}

- (instancetype)initWithBlock:(id (^)(NSDictionary *arguments, NSError **error))block;{
    if (self = [super initWithBaseURL:nil]) {
        self.block = block;
    }
    return self;
}

#pragma mark - private

- (BOOL)_validateURL:(NSURL *)URL{
    return [@[@"http", @"https"] containsObject:[URL scheme]];
}

- (BOOL)_handleURL:(NSURL *)URL arguments:(NSDictionary *)arguments output:(__autoreleasing id *)output error:(NSError *__autoreleasing *)error{
    if ([self block]) {
        id result = self.block(arguments, error);
        if (output) *output = result;
        
        return YES;
    }
    return NO;
}

@end