//
// statistics.i - SWIG interface
//

%module statistics

%{
//	#include "../config.h"
	#include "dar/statistics.hpp"
%}

%include "dar_types.i"

namespace libdar {
	class infinint;
}

%include "dar/statistics.hpp"