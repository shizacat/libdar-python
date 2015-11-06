//
// libdar.i - SWIG interface
//

%module libdar

%include "path.i"
%include "user_interaction.i"


%{
	#include "../config.h"
	#include "libdar.hpp"
%}

%include "typemaps.i"
%include "std_string.i"

%include "dar_types.i"

namespace libdar
{
        %typemap(in, numinputs=0) U_I& (U_I temp){
                $1 = &temp;
        }

        %typemap(argout) (U_I & major, U_I & medium, U_I & minor){
                $result = PyList_New(3);
                PyList_SetItem($result, 0, PyInt_FromLong(*$1));
                PyList_SetItem($result, 1, PyInt_FromLong(*$2));
                PyList_SetItem($result, 2, PyInt_FromLong(*$3));
        }

	extern void get_version(U_I & major, U_I & medium, U_I & minor, bool init_libgcrypt = true);
       
        
        %typemap(in, numinputs=0) U_16& (U_16 temp){ $1 = &temp; }

        %typemap(in, numinputs=0) std::string& (std::string temp){ $1 = &temp; }

        %typemap(argout) (U_I & major, U_I & medium, U_I & minor, U_16 & exception, std::string & except_msg){
                $result = PyList_New(5);
                PyList_SetItem($result, 0, PyInt_FromLong(*$1));
                PyList_SetItem($result, 1, PyInt_FromLong(*$2));
                PyList_SetItem($result, 2, PyInt_FromLong(*$3));
                PyList_SetItem($result, 3, PyInt_FromLong(*$4));
                PyList_SetItem($result, 4, PyUnicode_DecodeASCII($5->c_str(), strlen($5->c_str()), "strict") );
        }
 
    extern void get_version_noexcept(U_I & major, U_I & medium, U_I & minor, U_16 & exception, std::string & except_msg, bool init_libgcrypt = true);
        
    extern void close_and_clean();


//     extern archive* open_archive_noexcept(user_interaction & dialog,
// 		const path & chem, 	// где этот архив
// 		const std::string & basename,	// часть имени
// 		const std::string & extension,	// расширение файла
// 		const archive_options_read & options,	// опции archive_options_read()
// 		U_16 & exception,
// 		std::string & except_msg);
};

//%include pointer.i

//%include infinint.i

//%{
//#include "../config.h"
//#include "libdar.hpp"
//using namespace libdar;
//%}

//%include "libdar.hpp"

//%include pointer.i


//include statistics.i

