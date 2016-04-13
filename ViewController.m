//
//  ViewController.m
//  ShowWeather
//
//  Created by Lena Vansovich on 4/12/16.
//  Copyright (c) 2016 Lena Vansovich. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *indicator;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)refresh:(id)sender {
    NSURL *url = [[NSURL alloc] initWithString: @"https://query.yahooapis.com/v1/public/yql?q=select*%20from%20weather.forecast%20where%20woeid%3D834463&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"];
    
    NSData *contents = [[NSData alloc] initWithContentsOfURL:url];
    NSDictionary *forecasting = [NSJSONSerialization JSONObjectWithData:contents options:NSJSONReadingMutableContainers error:nil];
    
    NSDictionary* curentForecast = [[[[forecasting valueForKey:@"query"]valueForKey:@"results"]valueForKey:@"channel"]valueForKey:@"item"];
    
    NSString* tempLow = [[curentForecast valueForKey:@"forecast"][0] valueForKey:@"low"];
    NSString* tempHigh = [[curentForecast valueForKey:@"forecast"][0] valueForKey:@"high"];
    
    NSInteger temperature = ([tempLow integerValue] + [tempHigh integerValue])/2;
    
    temperature -= 32;
    temperature /= 2;
    temperature += temperature/10;
    
    NSString* output = [NSString stringWithFormat:@"%ld C", (long)temperature];
    
    [[self indicator] setText:output];
    
    if(temperature > 60)
    {
        [[self indicator] setTextColor:[UIColor redColor]];
    }
    else
    {
       if(temperature > 20)
       {
           [[self indicator] setTextColor:[UIColor orangeColor]];
       }
       else{
           if(temperature < 10)
           {
               [[self indicator] setTextColor:[UIColor blueColor]];
           }
           else
           {
               [[self indicator] setTextColor:[UIColor yellowColor]];
           }
       }
    }
}


@end
