//
// statistics.i - SWIG interface
//

// %module statistics

%{
#include "../config.h"
#include "statistics.hpp"
using namespace libdar;
%}

%ignore *::operator=;
%ignore *::operator++;
%ignore *::operator--;
%ignore *::operator[];
%ignore *::operator==;


%include dar_types.i

%include "statistics.hpp"