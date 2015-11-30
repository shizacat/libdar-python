//
// path.i - SWIG interface
//

%module path

%{
//	#include "../config.h"
	#include "dar/path.hpp"
%}

%include "dar_types.i"

%include "std_string.i"

%include "dar/path.hpp"