//
// secu_string.i - SWIG interface
//

%module secu_string

%{
//	#include "../config.h"
	#include "dar/secu_string.hpp"
%}

%include "dar_types.i"

%include "std_string.i"


%include "dar/secu_string.hpp"