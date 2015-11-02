//
// infinint.i - SWIG interface
//

%module infinint
%{
#include "../config.h"
#include <inttypes.h>
%}


%{
	#define LIBDAR_NO_EXCEPT 0

	typedef unsigned char U_8;
	typedef uint16_t U_16;
	typedef uint32_t U_32;
	typedef uint64_t U_64;
	typedef unsigned int U_I;
	typedef signed char S_8;
	typedef int16_t S_16;
	typedef int32_t S_32;
	typedef int64_t S_64;
	typedef signed int S_I;


	namespace libdar
	{
		class infinint : public on_pool
		{
			public :
				infinint(off_t a = 0);
			private :
				template <class T> void infinint_from(T a);
		};
	}
%}

%template(infinint_from_u8) infinint::infinint_from<U_8>
