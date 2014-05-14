//
//  KMFTableViewController.m
//  KMostFrequent
//

#import "KMFTableViewController.h"
#import "KMFCalculator.h"

@interface KMFTableViewController ()

@property (nonatomic) BOOL isLoading;
@property (nonatomic, strong) NSArray *results;

@end

@implementation KMFTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _isLoading = YES;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        KMFCalculator *calculator = [[KMFCalculator alloc] init];
        _results = [NSArray arrayWithArray:[calculator calculateKMostFrequent:_inputString numberOfElements:_numFrequentWords]];
        _isLoading = NO;
        dispatch_sync(dispatch_get_main_queue(), ^{
            // reload table view.
            [self.tableView reloadData];
        });
    });

    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_isLoading) {
        return 1;
    }
    else {
        return [_results count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KMFTableViewCell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"KMFTableViewCell"];
    }
    
    UILabel *textLabel = (UILabel*)[cell.contentView viewWithTag:100];
    
    if(_isLoading) {
        textLabel.text = @"Loading...";
    }
    else {
        NSString *resultString = [_results objectAtIndex:indexPath.row];
        textLabel.text = resultString;
    }
    
    return cell;
}



@end
