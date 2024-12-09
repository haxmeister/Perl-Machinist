=pod

=head1 NAME

Machinist::Math

Machinist math calculations made easy

=head1 SYNOPSIS

    use Machinist::Math;

    my $calc = Machinist::Math->new(mode => "imperial");


    say "rpm = ". $calc->rpm(300, .75);
    say "ssm = ". $calc->ssm(1000, .75);
    say "fpt = ". $calc->fpt(5, 500, 3);
    say "mmrr = ". $calc->mmrr(1, 1, .03937 );
    say "tmrr = ". $calc->tmrr(.016, .100, 350.);

    say "\n";

    $calc = Machinist::Math->new(mode => "metric");

    say "rpm = ". $calc->rpm(91.44, 19.05);
    say "ssm = ". $calc->ssm(1000, 25.4);
    say "fpt = ". $calc->fpt(5, 500, 3);
    say "mmrr = ". $calc->mmrr(25.4, 25.4, 1.);
    say "tmrr = ". $calc->tmrr(.4064,2.54, 106.68);

=head1 DESCRIPTION

An object oriented module using the new class feature requires B<perl 5.40> or greater. This module provides methods for typical math calculations done by machinists in both imperial and metric units. I attempted to use units of measure that are typical for professionals and the methods return values in the units that would be expected.

For instance when calculating surface speed, a machinist would expect the value to either be in Feet/Minute or Meters/Minute when the parameters may be in inches or millimeters.

=cut

use v5.40;
use warnings qw(-experimental);
use feature "class";

class Machinist::Math;

use constant {
    PI    => 4 * atan2(1, 1),
};


field $mode :param :reader;

=pod

=head2 Methods

=head3 new

Accepts one argument that is a "mode" that will either be "imperial" or "metric". Subsequent calculations will be based on the mode that is currently set.

 my $calc = Machinist::Math->new(mode => "imperial");

=head3 Modes

C<mode()>

Accepts no arguments

Returns the current mode.

C<set_mode(mode)>

Accepts one argument, a string that is either "imperial" or "metric". Sets the mode of the object such that all subsequent calculations are done using the corresponding units of measure

=cut

method set_mode($new_mode){
    $mode = $new_mode;
}

=pod

=head3 Rounds / Minute

C<rpm(surface speed, diameter)>

Accepts two arguments that are the surface speed and the diameter.

=over

=item

In metric mode the surface speed will be in "meters per minute" and the diameter will be in millimeters.

=item

In imperial mode this will be "surface feet per minute" and inches.

=back

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

=over

=item

In metric mode the diameter will be in millimeters.

=item

In imperial mode the diameter will be in inches.

=back

Returns a number that is either "Feet per minute" or "meters per minute" respectively.

=cut

method ssm($RPM, $DIA){
    return ($RPM * $DIA * PI) / 12 if $mode eq "imperial";
    return ($RPM * $DIA * PI) / 1000 if $mode eq "metric";
}

=pod

=head3 Feed / Tooth

C<fpt(feed per minute, rounds per minute, number of teeth)>

Accepts three arguments that are the "feed per minute", "rounds per minute" and "number of teeth".

=over

=item

In metric mode "feed per minute" will be in millimeters.

=item

In imperial mode "feed per minute will be in inches.

=back

Returns a number that is either "inches per tooth" or "millimeters per tooth" respectively.

=cut

method fpt($FPM, $RPM, $TEETH){
    return ($FPM / $RPM) / $TEETH;
}

=pod

=head3 Milling material removal rate

C<mmrr(feed per minute, width of cut, depth of cut)>

Accepts three arguments that are the "feed per minute", "width of cut" and "depth of cut".

=over

=item

In metric mode "width of cut" and "depth of cut" are in mm but the "feed per minute" is in meters/minute, the return value will be cubic centimeters.

=item

In imperial mode all arguments will be in inches and the return value will be cubic inches per minute.

=back

=cut

method mmrr($FPM, $WOC, $DOC){
    return $FPM * $WOC * $DOC if $mode eq "imperial";
    return ($FPM * $WOC * $DOC) / 1000 if $mode eq "metric"
}

=pod

=head3 Turning material removal rate

C<tmrr(feed per minute, depth of cut, surface speed)>

Accepts three arguments that are the "feed per revolution"and "depth of cut (radially)" and "surface speed".

=over

=item

In metric mode "feed per revolution" and "depth of cut" will be in millimeters and "surface speed" will be in meters/minute, the return value will be cubic centimeters/minute.

=item

In imperial mode "feed per revolution" and "depth of cut" will be in inches and "surface speed" will be in feet/minute with a return value in cubic inches/minute.

=back

=cut

method tmrr($FPR, $DOC, $SSM){
    return $FPR * $DOC * $SSM * 12 if $mode eq "imperial";
    return $FPR * $DOC * $SSM if $mode eq "metric";
}

1;
