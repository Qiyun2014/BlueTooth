//
//  CBTManager.h
//  BlueTooth
//
//  Created by yryz on 2020/1/6.
//  Copyright © 2020 com.yryz.qiyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger, CBTManagerAuthrozationStatus) {
    CBTManagerAuthrozationNotDetermined = 0,
    CBTManagerAuthrozationRestricted,
    CBTManagerAuthrozationDenied,
    CBTManagerAuthrozationAllowedAlways
};


@interface CBTManager : NSObject


@property (strong, nonatomic) NSMutableArray        *discoverPeripherals;

/// 获取外设授权状态
+ (CBTManagerAuthrozationStatus)checkAuthrozationStatusForManager:(CBManager *)manager;


// 扫描外设
- (void)scanPeripherals;


@end

NS_ASSUME_NONNULL_END
