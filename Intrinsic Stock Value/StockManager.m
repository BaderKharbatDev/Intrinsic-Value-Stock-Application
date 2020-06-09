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
//        NSError *error;
//        NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString: @"https://dumbstockapi.com/stock?exchanges=NYSE"]];
//        NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//        _stockArray = [[NSMutableArray alloc] init];
//        for(int i = 0; i < json.count; i++) {
//            NSString * ticker = json[i][@"ticker"];
//            NSString * name = json[i][@"name"];
//            NSDictionary * dict = [[NSDictionary alloc] initWithObjectsAndKeys: ticker, @"DisplayText", name, @"DisplaySubText", ticker,@"CustomObject", nil];
//            [_stockArray addObject: dict];
//        }
    }
    return(self);
}

-(void) setTicker:(NSString *)ticker {
    //gets the eps
    NSString* url1 = @"https://sandbox.iexapis.com/stable/stock/";
    NSString* api1 = @"/stats?token=Tsk_6d28769d31b64ac9a50a626a09597de7";
    url1 = [NSString stringWithFormat:@"%@%@", url1 , [ticker uppercaseString]];
    url1 = [NSString stringWithFormat:@"%@%@", url1 , api1];
    
   NSError *error;
   NSData *data1 = [NSData dataWithContentsOfURL: [NSURL URLWithString:url1]];
   NSDictionary *json1 = [NSJSONSerialization JSONObjectWithData:data1 options:kNilOptions error:&error];
    
    self.tickerName = ticker;
    self.tickerFullName = json1[@"companyName"];
    self.price = 0;
    self.eps = [json1[@"ttmEPS"] doubleValue];
    self.pe = [json1[@"peRatio"] doubleValue];
    
}

-(double)getIV: (double) minReturn : (double) estimatedGrowth : (double) pe {
    double tenyrEPS = _eps * pow(1 + estimatedGrowth, 10);
    double tenyrEP = tenyrEPS*pe;
    double intrinsicValue = tenyrEP/pow(1 + minReturn, 10);
    return intrinsicValue;
}

@end
