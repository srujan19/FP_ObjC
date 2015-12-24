//
//  NSString-Hashes.h
//  FP_ObjC
//
//  Created by Srujan Simha Adicharla on 12/23/15.
//  Copyright © 2015 Srujan Simha Adicharla. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Hashes)

@property (nonatomic, readonly) NSString *md5;
@property (nonatomic, readonly) NSString *sha1;
@property (nonatomic, readonly) NSString *sha224;
@property (nonatomic, readonly) NSString *sha256;
@property (nonatomic, readonly) NSString *sha384;
@property (nonatomic, readonly) NSString *sha512;

@end
