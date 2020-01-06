//
//  CBTPeripheralManager.h
//  BlueTooth
//
//  Created by yryz on 2020/1/6.
//  Copyright © 2020 com.yryz.qiyun. All rights reserved.
//

#import "CBTManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface CBTPeripheralManager : CBTManager

@property (strong, nonatomic) CBPeripheralManager   *peripheralManager;

@end

NS_ASSUME_NONNULL_END
