
use v5.40;
use warnings qw(-experimental);
use feature "class";

class Machinist::Math;

use constant {
    PI    => 4 * atan2(1, 1),
};


field $mode :param;

=head2 Methods

=head3 Rounds / Minute

C<rpm(surface speed, diameter)>

Accepts two arguments that are the surface speed and the diameter.
In metric mode the surface speed will be in "meters per minute" and the diameter will be in millimeters.
In imperial mode this will be "surface feet per minute" and inches.
Returns a number that is "rounds per minute".

=cut
method rpm($SSM, $DIA){
    return ($SSM * 3.82) / $DIA if $mode eq "imperial";
    return (1000 * $SSM) / (PI * $DIA) if $mode eq "metric";
}

=pod

=head3 Surface Speed / Minute

C<ssm(rounds per minute, diameter)>

Accepts two arguments that are the "rounds per minute" and the diameter.
In metric mode the diameter will be in millimeters.
In imperial mode the diameter will be in inches.
Returns a number that is either "Feet per minute" or "Meters per minute" respectively.

=cut

method ssm($RPM, $DIA){
    return ($RPM * $DIA * PI) / 12 if $mode eq "imperial";
    return (PI * $DIA * $RPM) / 1000 if $mode eq "metric";
}

=pod

=head3 Feed / Tooth

C<fpt(feed per minute, rounds per minute, number of teeth)>

Accepts three arguments that are the "feed per minute", "rounds per minute" and "number of teeth".
In metric mode "feed per minute" will be in millimeters.
In imperial mode "feed per minute will be in inches.
Returns a number that is either "inches per tooth" or "millimeters per tooth" respectively.

=cut

method fpt($FPM, $RPM, $TEETH){
    return ($FPM / $RPM) / $TEETH if $mode eq "imperial";
    return $FPM / ($TEETH * $RPM) if $mode eq "metric";
}

=pod

=head3 Milling material removal rate

C<mmrr(feed per minute, width of cut, depth of cut)>

Accepts three arguments that are the "feed per minute", "width of cut" and "depth of cut".
In metric mode "feed per minute" will be in "millimeters per minute" and width/depth will be in millimeters.
In imperial mode "feed per minute will be in "inches per minute" and width/depth will be in inches.
Returns a number that is either "cubic inches per minute" or "centimeters per minute" respectively.

=cut

method mmrr($FPM, $WOC, $DOC){
    return $FPM * $WOC * $DOC if $mode eq "imperial";
    return ($FPM * $WOC * $DOC) / 1000 if $mode eq "metric";
}

=pod

=head3 Turning material removal rate

C<tmrr(feed per minute, width of cut, depth of cut)>

Accepts three arguments that are the "feed per revolution", "depth of cut (radially)" and "feed per minute".
In metric mode "feed per revolution", "depth of cut" and "feed per minute" will be in millimeters.
In imperial mode "feed per revolution", "feed per minute" will be in inches.
Returns a number that is either "cubic inches per minute" or "cubic centimeters per minute" respectively.

=cut

method tmrr($FPR, $DOC, $FPM){
    return $FPR * $DOC * $FPM if $mode eq "imperial";
    return ($FPR * $DOC * $FPM) / 1000 if $mode eq "metric";
}

1;
