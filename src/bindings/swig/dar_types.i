/*********************************************************************/
// libdar-python - binding libdar with python
// Copyright (C) 2015 Alexey Matveev
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// to contact the author : https://github.com/shizacat/libdar-python
/*********************************************************************/

//
// dar_types.i
//


#pragma SWIG nowarn=401

%ignore *::operator=;
%ignore *::operator[];

namespace libdar {
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

	enum compression
    {
		none = 'n',  ///< no compression
		gzip = 'z',  ///< gzip compression
		bzip2 = 'y', ///< bzip2 compression
		lzo = 'l',   ///< lzo compression
//		xz = 'x'     ///< lzma compression
    };
}

// #ifndef OS_BITS
// 	#if HAVE_INTTYPES_H
// 		namespace libdar
//         {
//             typedef unsigned char U_8;
//             typedef uint16_t U_16;
//             typedef uint32_t U_32;
//             typedef uint64_t U_64;
//             typedef size_t U_I;
//             typedef signed char S_8;
//             typedef int16_t S_16;
//             typedef int32_t S_32;
//             typedef int64_t S_64;
//             typedef signed int S_I;
//         }
// 	#endif
// #else
// 	#if OS_BITS == 32
// 		namespace libdar
//         {
//             typedef unsigned char U_8;
//             typedef unsigned short U_16;
//             typedef unsigned long U_32;
//             typedef unsigned long long U_64;
//             typedef size_t U_I;
//             typedef signed char S_8;
//             typedef signed short S_16;
//             typedef signed long S_32;
//             typedef signed long long S_64;
//             typedef signed int S_I;
//         }
// 	#else // OS_BITS != 32
//     #if OS_BITS == 64
//         namespace libdar
//         {
//             typedef unsigned char U_8;
//             typedef unsigned short U_16;
//             typedef unsigned int U_32;
//             typedef unsigned long long U_64;
//             typedef size_t U_I;
//             typedef signed char S_8;
//             typedef signed short S_16;
//             typedef signed int S_32;
//             typedef signed long long S_64;
//             typedef signed int S_I;
//         }
// 	#endif // OS_BITS == 64
//     #endif // OS_BITS == 32
// #endif // OS_BITS not defined