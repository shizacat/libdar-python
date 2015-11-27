//
// statistics.i - SWIG interface
//

%module statistics

%{
//	#include "../config.h"
	#include "statistics.hpp"
%}

%include "dar_types.i"

namespace libdar {
	class infinint;
}

%include "statistics.hpp"