//
//  UIImage+Utils.h
//  Pytorch-iOS-Device
//
//  Created by taox on 7/5/19.
//  Copyright © 2019 Facebook. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <memory>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Utils)

- (NSData* )rgb;
- (UIImage* )resize:(CGSize)sz;
- (UIImage* )rgbImage;


@end

NS_ASSUME_NONNULL_END
