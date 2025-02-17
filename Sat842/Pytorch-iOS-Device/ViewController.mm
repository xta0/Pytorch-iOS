//
//  Copyright © 2019年 Vizlab. All rights reserved.
//

#import "UIImage+Utils.h"
#import "ViewController.h"
#import "ImagePredictor.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *resultLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (strong, nonatomic) NSArray* labels;
@property (strong, nonatomic) NSArray* images;
@end

@implementation ViewController{
    NSUInteger _currentSelectedIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ResNet18";
    self.images = @[@"wolf_400x400.jpg",
                    @"frog_400x400.jpg",
                    @"snake_400x400.jpg",
                    @"dog_224x224.png"];
    _currentSelectedIndex = 0;
    self.imageView.image = [UIImage imageNamed:self.images[_currentSelectedIndex]];
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onImageTapped:)]];
    self.indicator.hidden = YES;
    //load labels and run prediction
    [self loadLabels];
    [self runPredict];
}

- (void)runPredict {
    [ImagePredictor predict:self.imageView.image
             withModel:[[NSBundle mainBundle] pathForResource:@"resnet18" ofType:@"pt"]
            Completion:^(NSArray<NSNumber *> * _Nonnull scores, NSArray<NSNumber *> * _Nonnull indexes) {
                if(scores.count > 0 && indexes.count > 0 && self.labels.count > 0){
                    NSString* result = @"";
                    for(int i=0; i<indexes.count; ++i){
                        NSString* label = self.labels[indexes[i].integerValue];
                        NSString* content = [NSString stringWithFormat:@"- [Score]: %@, [label]: %@ \n\n", scores[i], label];
                        result = [result stringByAppendingString:content];
                    }
                    [self.indicator stopAnimating];
                    self.indicator.hidden = YES;
                    self.resultLabel.text = result;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.resultLabel scrollRectToVisible:{0,0,CGRectGetWidth(self.resultLabel.bounds),1} animated:NO];
                    });
                    
                }
            }];
}

- (void)loadLabels {
    NSError* err;
    NSString* str = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"synset_words" ofType:@"txt"]
                                              encoding:NSUTF8StringEncoding
                                                 error:&err];
    if(!err){
        _labels = [str componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    }
}

- (void)onImageTapped:(__unused id) sender{
    _currentSelectedIndex+=1;
    if(_currentSelectedIndex == self.images.count){
        _currentSelectedIndex = 0;
    }
    self.imageView.image = [UIImage imageNamed:self.images[_currentSelectedIndex]];
    self.indicator.hidden = NO;
    [self.indicator startAnimating];
    self.resultLabel.text = @"";
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self runPredict];
    });
}



@end
