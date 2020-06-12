//
//  StockManager.m
//  Intrinsic Stock Value
//
//  Created by Bader on 5/24/20.
//  Copyright © 2020 Nebo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StockManager.h"

@implementation StockManager

-(id) initAndGet {
    self = [super init];
    if(self) {
        self.stockData = [DataIO initManagerWithData: @"aapl"];
    }
    return(self);
}

-(void) setTicker:(NSString *)ticker {
    self.stockData = [DataIO initManagerWithData: ticker];
}

-(double)getIV: (double) minReturn : (double) estimatedGrowth : (double) pe {
    double _eps = [[_stockData objectForKey:@"eps"] doubleValue];
    double tenyrEPS = _eps * pow(1 + estimatedGrowth, 10);
    double tenyrEP = tenyrEPS*pe;
    double intrinsicValue = tenyrEP/pow(1 + minReturn, 10);
    return intrinsicValue;
}

@end
