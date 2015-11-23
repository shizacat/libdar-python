//
// secu_string.i - SWIG interface
//

%module secu_string

%{
	#include "../config.h"
	#include "secu_string.hpp"
%}

%include "std_string.i"
%include "dar_types.i"

%include "secu_string.hpp"