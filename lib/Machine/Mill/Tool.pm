 
use v5.38;
use feature 'class';
use warnings -experimental;

class Machine::Mill::Tool

field $diameter   :param;
field $flutes     :param;
field $max_depth  :param;
field $lead_angle :param //= 90;

method diameter{ return $diameter }
method flutes { return $flutes }
method max_depth { return $max_depth }
method lead_angle { return $lead_angle }
