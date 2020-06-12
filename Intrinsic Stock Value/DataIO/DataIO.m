//
//  DataIO.m
//  Intrinsic Stock Value
//
//  Created by Bader on 6/9/20.
//  Copyright © 2020 Nebo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataIO.h"

@implementation DataIO

+(NSDictionary *)initManagerWithData: (NSString *) ticker {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:ticker  forKey:@"ticker"];

    @try {
        NSString* url = @"https://sandbox.iexapis.com/stable/stock/";
        NSString* api = @"/stats?token=Tsk_6d28769d31b64ac9a50a626a09597de7";
        url = [NSString stringWithFormat:@"%@%@", url , [ticker uppercaseString]];
        url = [NSString stringWithFormat:@"%@%@", url , api];
        
        NSError *error;
        NSData *data1 = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
        NSDictionary *json1 = [NSJSONSerialization JSONObjectWithData:data1 options:kNilOptions error:&error];
        
        if(error != nil)
            NSLog(@"%@", url);
        
        [dict setObject:json1[@"companyName"]  forKey:@"name"];
        [dict setObject:json1[@"ttmEPS"]  forKey:@"eps"];
        [dict setObject:json1[@"peRatio"]  forKey:@"pe"];
        [dict setObject:json1[@"dividendYield"]  forKey:@"div"];
        [dict setObject:json1[@"exDividendDate"]  forKey:@"divdate1"];
        [dict setObject:json1[@"nextDividendDate"]  forKey:@"divdate2"];
        [dict setObject:json1[@"week52high"]  forKey:@"yearHigh"];
        [dict setObject:json1[@"week52low"]  forKey:@"yearLow"];
        [dict setObject:json1[@"marketcap"]  forKey:@"cap"];
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        NSLog(@"API 1 did not retrieve data properly");
    }
    @try {
        NSString* url2 = @"https://sandbox.iexapis.com/stable/stock/";
        NSString* api2 = @"/advanced-stats?token=Tsk_6d28769d31b64ac9a50a626a09597de7";
        url2 = [NSString stringWithFormat:@"%@%@", url2 , [ticker uppercaseString]];
        url2 = [NSString stringWithFormat:@"%@%@", url2 , api2];
        
        NSError *error2;
        NSData *data2 = [NSData dataWithContentsOfURL: [NSURL URLWithString:url2]];
        NSDictionary *json2 = [NSJSONSerialization JSONObjectWithData:data2 options:kNilOptions error:&error2];
        
        if(error2 != nil)
            NSLog(@"%@", url2);
    
        [dict setObject:json2[@"EBITDA"]  forKey:@"ebitda"];
        [dict setObject:json2[@"debtToEquity"]  forKey:@"debtratio"];
        [dict setObject:json2[@"pegRatio"]  forKey:@"peg"];
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        NSLog(@"API 2 did not retrieve data properly");
    }
    @try {
        NSString* url3 = @"https://sandbox.iexapis.com/stable/stock/";
        NSString* api3 = @"/cash-flow?token=Tsk_6d28769d31b64ac9a50a626a09597de7";
        url3 = [NSString stringWithFormat:@"%@%@", url3 , [ticker uppercaseString]];
        url3 = [NSString stringWithFormat:@"%@%@", url3 , api3];
        
        NSError *error3;
        NSData *data3 = [NSData dataWithContentsOfURL: [NSURL URLWithString:url3]];
        NSDictionary *json3 = [NSJSONSerialization JSONObjectWithData:data3 options:kNilOptions error:&error3];
        
        if(error3 != nil)
            NSLog(@"%@", url3);
        
        [dict setObject:json3[@"cashflow"][0][@"cashFlow"]  forKey:@"fcf"];
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        NSLog(@"API 3 did not retrieve data properly");
    }
    @try {
        [dict setObject: [self getGrowth: ticker] forKey:@"growth"];
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        NSLog(@"API 4 did not retrieve data properly");
    }

    return dict;
}


    +(NSString *)getGrowth: (NSString *) ticker {
        
        NSString* myURLString = @"https://finance.yahoo.com/quote/";
        NSString* end = @"/analysis/";
        myURLString = [NSString stringWithFormat:@"%@%@", myURLString, [ticker uppercaseString]];
        myURLString = [NSString stringWithFormat:@"%@%@", myURLString , end];
        
        NSURL *myURL = [NSURL URLWithString:myURLString];
        NSError *error = nil;
        NSString *myHTMLString = [NSString stringWithContentsOfURL:myURL encoding: NSUTF8StringEncoding error:&error];
        
        if(error != nil)
            [NSException raise:@"Growth API Failed" format:@"Growth URL changed"];
        
        NSRange range = [myHTMLString rangeOfString:@"431\">"];
        NSString * sub = [myHTMLString substringFromIndex:(range.location + range.length)];
        NSArray *splitStringArray = [sub componentsSeparatedByString:@"%"];

        return splitStringArray[0];
}


@end
