#!/usr/bin/env perl

my $inputDir = "grey";
my %colorDescription = (
 # subDirColor lighterColor mediumColor darkerColor
 "blue" => "#a4c0e4 #00438a #00316e",
 "brown" => "#debc85 #57401e #382509",
 "emerald" => "#99dcc6 #00734d #00583f",
 "green" => "#d8e8c2 #00892c #006e29",
 "hot_orange" => "#ffd9b0 #cf4913 #ac4311",
 "navy" => "#c3b4da #34176e #1d0a55",
 "purple" => "#f9cade #bf0361 #9c0f56",
 "red" => "#f9ccca #bf0303 #9c0f0f",
 "sea_blue" => "#a8dde0 #006066 #00484d",
 "violet" => "#e8b7d7 #85026c #6a0056",
 "yellow" => "#fff6c8 #f3c300 #e3ad00",
 "white" => "#ffffff #d3d7cf #888a85"
);

sub convertFile($) {
    my $inputFile = shift;
    print "processing " . $inputFile . "\n";
    foreach my $color (keys %colorDescription) {
        my @descr = split(' ', $colorDescription{$color});
        my $lighterColor = $descr[0];
        my $mediumColor = $descr[1];
        my $darkerColor = $descr[2];

        #print $color . " " . $lighterColor . "\n";
        open(IN, "<$inputDir/$inputFile") or die "$inputDir/$inputFile not found";
        open(OUT, ">$color/$inputFile") or die "Cannot create $color/$inputFile";
        while(<IN>) {
            s/#eeeeec;/$lighterColor;/g;
            s/#555753/$mediumColor/g;
            s/#2e3436/$darkerColor/g;
            print OUT $_;
        }
        close IN;
        close OUT;
    }
}

my $argument = $ARGV[0];
if ($argument eq "") {
    print "Usage: $0 [ -a | file.svg ]\n";
} elsif ($argument eq '-a') {
    my @files=`ls -1 $inputDir`;
    foreach $_ (@files) {
        chomp;
        convertFile($_);
    }
} else {
    convertFile($argument);
}




#for icon in $(ls *.svg); do
#
#cp $icon $( echo $icon | sed s/.svg// )-old.svg
#
#perl -pi -e "s/#eeeeec;/$lighterColor;/g" $icon
#perl -pi -e "s/fill:#555753;fill-rule:evenodd;stroke:#2e3436;/fill:$mediumColor;fill-rule:evenodd;stroke:$darkerColor;/g" $icon
## perl -pi -e "s/style=\"stop-color:#eeeeec;stop-opacity:1;\"/style=\"stop-color:$lighterColor;stop-opacity:1;\""
#done
