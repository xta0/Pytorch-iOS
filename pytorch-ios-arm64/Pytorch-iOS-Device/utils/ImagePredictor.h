//
//  Predictor.h
//  Pytorch-iOS-Device
//
//  Created by taox on 7/10/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImagePredictor : NSObject

+ (void)predict:(UIImage* )image
      withModel:(NSString* )path
     Completion:(void(^__nullable)(NSArray<NSNumber* >* scores,
                                   NSArray<NSNumber*>* index)) completion;

@end

NS_ASSUME_NONNULL_END
