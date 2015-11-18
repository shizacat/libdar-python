//
// statistics.i - SWIG interface
//

%module statistics

// %include "infinint.i"
%include "dar_types.i"

%{
	#include "../config.h"
	#include "statistics.hpp"
	// using namespace libdar;
%}


namespace libdar {
	// class statistics;
	// class infinint;

	// %exception statistics::~statistics {
	// 	try {
	// 		$action
	// 	} catch () {
	// 		PyErr_SetString(PyExc_RuntimeError, const_cast<char*>(e.what()));
	// 		return NULL;
	// 	}
	// }

	class statistics
    {
    public:
		statistics(bool lock = true);
		statistics(const statistics & ref);
		~statistics();
	};
}

// %include "statistics.hpp"