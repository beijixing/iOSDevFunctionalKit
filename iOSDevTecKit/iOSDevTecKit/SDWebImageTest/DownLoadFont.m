//
//  DownLoadFont.m
//  iOSDevTecKit
//
//  Created by horse on 2017/1/5.
//  Copyright © 2017年 郑光龙. All rights reserved.
//

#import "DownLoadFont.h"
#import <CoreText/CoreText.h>
@interface DownLoadFont()
@end

@implementation DownLoadFont

-(instancetype)init {
    if (self = [super init]) {
        self.fontNames = @[@"STXingkai-SC-Light",
                           @"DFWaWaSC-W5",
                           @"FZLTXHK--GBK1-0",
                           @"STLibian-SC-Regular",
                           @"LiHeiPro",
                           @"HiraginoSansGB-W3",
                           @"STBaoliSC-Regular",
                           @"STFangsong",
                           @"STHupo",
                           @"MLingWaiMedium-SC",
                           @"HanziPenSC-W3",
                           @"Weibei-SC-Bold"];
    }
    return self;
}
- (void)asynchronouslySetFontName:(NSString *)fontName with:(SetTextBlock)setTextBlock
{
    UIFont* aFont = [UIFont fontWithName:fontName size:12.];
    // If the font is already downloaded
    if (aFont && ([aFont.fontName compare:fontName] == NSOrderedSame || [aFont.familyName compare:fontName] == NSOrderedSame)) {
        // Go ahead and display the sample text.
        setTextBlock();
        return;
    }
    
    // Create a dictionary with the font's PostScript name.
    NSMutableDictionary *attrs = [NSMutableDictionary dictionaryWithObjectsAndKeys:fontName, kCTFontNameAttribute, nil];
    
    // Create a new font descriptor reference from the attributes dictionary.
    CTFontDescriptorRef desc = CTFontDescriptorCreateWithAttributes((__bridge CFDictionaryRef)attrs);
    
    NSMutableArray *descs = [NSMutableArray arrayWithCapacity:0];
    [descs addObject:(__bridge id)desc];
    CFRelease(desc);
    
    __block BOOL errorDuringDownload = NO;
    
    // Start processing the font descriptor..
    // This function returns immediately, but can potentially take long time to process.
    // The progress is notified via the callback block of CTFontDescriptorProgressHandler type.
    // See CTFontDescriptor.h for the list of progress states and keys for progressParameter dictionary.
    CTFontDescriptorMatchFontDescriptorsWithProgressHandler( (__bridge CFArrayRef)descs, NULL,  ^(CTFontDescriptorMatchingState state, CFDictionaryRef progressParameter) {
        
        //NSLog( @"state %d - %@", state, progressParameter);
        
        double progressValue = [[(__bridge NSDictionary *)progressParameter objectForKey:(id)kCTFontDescriptorMatchingPercentage] doubleValue];
        
        if (state == kCTFontDescriptorMatchingDidBegin) {
            dispatch_async( dispatch_get_main_queue(), ^ {
                // Show an activity indicator
//                [_fActivityIndicatorView startAnimating];
//                _fActivityIndicatorView.hidden = NO;
                
                // Show something in the text view to indicate that we are downloading
//                _fTextView.text= [NSString stringWithFormat:@"Downloading %@", fontName];
//                _fTextView.font = [UIFont systemFontOfSize:14.];
                
                NSLog(@"Begin Matching");
            });
        } else if (state == kCTFontDescriptorMatchingDidFinish) {
            dispatch_async( dispatch_get_main_queue(), ^ {
                // Remove the activity indicator
//                [_fActivityIndicatorView stopAnimating];
//                _fActivityIndicatorView.hidden = YES;
                
                // Display the sample text for the newly downloaded font
//                NSUInteger sampleIndex = [_fontNames indexOfObject:fontName];
//                _fTextView.text = [_fontSamples objectAtIndex:sampleIndex];
//                _fTextView.font = [UIFont fontWithName:fontName size:24.];
                
                setTextBlock();
                
                // Log the font URL in the console
                CTFontRef fontRef = CTFontCreateWithName((__bridge CFStringRef)fontName, 0., NULL);
                CFStringRef fontURL = CTFontCopyAttribute(fontRef, kCTFontURLAttribute);
                NSLog(@"%@", (__bridge NSURL*)(fontURL));
                CFRelease(fontURL);
                CFRelease(fontRef);
                
                if (!errorDuringDownload) {
                    NSLog(@"%@ downloaded", fontName);
                }
            });
        } else if (state == kCTFontDescriptorMatchingWillBeginDownloading) {
            dispatch_async( dispatch_get_main_queue(), ^ {
                // Show a progress bar
//                _fProgressView.progress = 0.0;
//                _fProgressView.hidden = NO;
                NSLog(@"Begin Downloading");
            });
        } else if (state == kCTFontDescriptorMatchingDidFinishDownloading) {
            dispatch_async( dispatch_get_main_queue(), ^ {
                // Remove the progress bar
//                _fProgressView.hidden = YES;
                NSLog(@"Finish downloading");
            });
        } else if (state == kCTFontDescriptorMatchingDownloading) {
            dispatch_async( dispatch_get_main_queue(), ^ {
                // Use the progress bar to indicate the progress of the downloading
//                [_fProgressView setProgress:progressValue / 100.0 animated:YES];
                NSLog(@"Downloading %.0f%% complete", progressValue);
            });
        } else if (state == kCTFontDescriptorMatchingDidFailWithError) {
            // An error has occurred.
            // Get the error message
            NSError *error = [(__bridge NSDictionary *)progressParameter objectForKey:(id)kCTFontDescriptorMatchingError];
            if (error != nil) {
//                _errorMessage = [error description];
            } else {
//                _errorMessage = @"ERROR MESSAGE IS NOT AVAILABLE!";
            }
            // Set our flag
            errorDuringDownload = YES;
            
            dispatch_async( dispatch_get_main_queue(), ^ {
//                _fProgressView.hidden = YES;
//                NSLog(@"Download error: %@", _errorMessage);
            });
        }
        
        return (bool)YES;
    });
    
}
@end
