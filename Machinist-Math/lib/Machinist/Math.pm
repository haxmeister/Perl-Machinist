
use v5.40;
use warnings qw(-experimental);
use feature "class";


class Machinist::Math{
use DDP;
    use constant {
        PI    => 4 * atan2(1, 1),
    };

    method rpm(%params){
        my $speed = $params{speed};
        my $dia   = $params{diameter};
        my $calc  = $speed / (PI * $dia);
        return $calc;
    }

    # surface speed
    method ss(%params){
        my $rpm  = $params{rpm};
        my $dia  = $params{diameter};
        my $calc = $rpm * $dia * PI;
        return $calc;
    }

    method fpt(%params){
        my $feed  = $params{feed};
        my $rpm   = $params{rpm};
        my $teeth = $params{teeth};
        return ($feed / $rpm) / $teeth;
    }
    
    method fpm(%params){
        my $rpm = $params{rpm};
        my $teeth = $params{teeth};
        my $fpt = $params{fpt};
        my $calc = $rpm * $teeth * $fpt;
        return $calc;
    }

    method mill_mrr(%params){
        my $fpm = $params{feed};
        my $woc = $params{width};
        my $doc = $params{depth};
        my $calc = $fpm * $woc * $doc;
        return $calc;
    }

    method turn_mrr(%params){
        my $fpr = $params{feed};
        my $doc = $params{depth};
        my $ss = $params{ss};
        my $calc = $fpr * $doc * $ss;
        return $calc;
    }
    
    method drill_mrr(%params){
        my $dia = $params{diameter};
        my $feed = $params{fpm};
        my $calc = (PI * ($dia ** 2) / 4) * $feed;
    }
    
}
