//
// libdar.i - SWIG interface
//

%module libdar

%include "path.i"
%include "user_interaction.i"
// %include "infinint.i"
%include "archive.i"
%include "statistics.i"

%{
	#include "../config.h"
	#include "libdar.hpp"
%}

%include "typemaps.i"
%include "std_string.i"
%include "exception.i" 

%include "dar_types.i"


#define EXCEPT_WRAP(e_n, e_str) \
	*e_str = "[" + std::to_string(*e_n) + "]"+*e_str; \
	SWIG_exception(SWIG_RuntimeError, e_str->c_str());

%inline %{
	libdar::user_interaction* CastToUser_iteraction(libdar::user_interaction_callback* base){
		return static_cast<libdar::user_interaction*>(base);
	}

	libdar::statistics* statisticsNullPtr(){
		return (libdar::statistics*) NULL;
	}
%}

namespace libdar
{
	%typemap(in, numinputs=0) std::string& except_msg (std::string temp) { $1 = &temp; }
	%typemap(in, numinputs=0) U_16& exception (U_16 temp) { $1 = &temp; }

	%typemap(in, numinputs=0) U_I& (U_I temp) { $1 = &temp; }

	// ----------------------------------------------------

	%typemap(argout) (U_I & major, U_I & medium, U_I & minor){
		$result = PyList_New(3);
		PyList_SetItem($result, 0, PyInt_FromLong(*$1));
		PyList_SetItem($result, 1, PyInt_FromLong(*$2));
		PyList_SetItem($result, 2, PyInt_FromLong(*$3));
	}

	extern void get_version(U_I & major, U_I & medium, U_I & minor, bool init_libgcrypt = true);    

	// ----------------------------------------------------

	%typemap(argout) (U_I & major, U_I & medium, U_I & minor, U_16 & exception, std::string & except_msg){
		$result = PyList_New(5);
		PyList_SetItem($result, 0, PyInt_FromLong(*$1));
		PyList_SetItem($result, 1, PyInt_FromLong(*$2));
		PyList_SetItem($result, 2, PyInt_FromLong(*$3));
		PyList_SetItem($result, 3, PyInt_FromLong(*$4));
		PyList_SetItem($result, 4, PyUnicode_FromString($5->c_str()) );
	}
 
	extern void get_version_noexcept(U_I & major, U_I & medium, U_I & minor, U_16 & exception, std::string & except_msg, bool init_libgcrypt = true);

	// ----------------------------------------------------  

	%typemap(argout) (user_interaction & dialog, const path & chem, const std::string & basename, const std::string & extension, const archive_options_read & options, U_16 & exception, std::string & except_msg) {
		PyObject *o = $result;
		$result = PyList_New(3);
		PyList_SetItem($result, 0, o);
		PyList_SetItem($result, 1, PyInt_FromLong(*$6));
		PyList_SetItem($result, 2, PyUnicode_FromString($7->c_str()) );
	}

	extern archive* open_archive_noexcept(user_interaction & dialog,
		const path & chem, 	// где этот архив
		const std::string & basename,	// часть имени
		const std::string & extension,	// расширение файла
		const archive_options_read & options,	// опции archive_options_read()
		U_16 & exception,
		std::string & except_msg);

	// ----------------------------------------------------  

	%typemap(argout) (user_interaction & dialog,
			const path & fs_root,
			const path & sauv_path,
			const std::string & filename,
			const std::string & extension,
			const archive_options_create & options,
			statistics * progressive_report,
			U_16 & exception,
			std::string & except_msg) {

		PyObject *o = $result;
		$result = PyList_New(3);
		PyList_SetItem($result, 0, o);
		PyList_SetItem($result, 1, PyInt_FromLong(*$8));
		PyList_SetItem($result, 2, PyUnicode_FromString($9->c_str()) );
	}

	// (arh_ptr, except, except_msg) = libdar.create_archive_noexcept(libdar.CastToUser_iteraction( u_i_cb ), libdar.path(''), libdar.path(''), '', '', libdar.archive_options_create(), libdar.statisticsNullPtr() )
	extern archive *create_archive_noexcept(
		user_interaction & dialog,
		const path & fs_root,
		const path & sauv_path,
		const std::string & filename,
		const std::string & extension,
		const archive_options_create & options,
		statistics * progressive_report,
		U_16 & exception,
		std::string & except_msg);

    // ---------------------------------------------------- 

 //     extern archive *merge_archive_noexcept(user_interaction & dialog,
	// 				   const path & sauv_path,
	// 				   archive *ref_arch1,
	// 				   const std::string & filename,
	// 				   const std::string & extension,
	// 				   const archive_options_merge & options,
	// 				   statistics * progressive_report,
	// 				   U_16 & exception,
	// 				   std::string & except_msg);

	// ---------------------------------------------------- 

	extern void close_archive_noexcept(archive *ptr,
		U_16 & exception,
		std::string & except_msg);

	// ---------------------------------------------------- 

	%typemap(argout) (statistics* ptr,
		U_16 & exception,
		std::string & except_msg)
	{
		if ( $1 == nullptr )
			Py_XDECREF(obj0);

		$result = PyList_New(2);
		PyList_SetItem($result, 0, PyInt_FromLong(*$2));
		PyList_SetItem($result, 1, PyUnicode_FromString($3->c_str()) );
	}

	extern void close_statistics_noexcept(statistics* ptr,
		U_16 & exception,
		std::string & except_msg);

	// ---------------------------------------------------- 

	%typemap(argout) (user_interaction & dialog,
			archive *ptr,
			const path &fs_root,
			const archive_options_extract & options,
			statistics * progressive_report,
			U_16 & exception,
			std::string & except_msg) 
	{
		if ( *$6 != 0 )
		{
			EXCEPT_WRAP($6,$7)
			// *$7 = "[" + std::to_string(*$6) + "]"+*$7;
			// SWIG_exception(SWIG_RuntimeError, $7->c_str());
		}

		// libdar::close_statistics_noexcept(result, *$6, *$7);

		// if ( *$6 != 0 ) {
		// 	EXCEPT_WRAP($6,$7)
		// }

		// Py_XDECREF($result);
		// $result = SWIG_Py_Void();

		// PyObject *o = $result;
		// $result = PyList_New(3);
		// PyList_SetItem($result, 0, o);
		// PyList_SetItem($result, 1, PyInt_FromLong(*$6));
		// PyList_SetItem($result, 2, PyUnicode_FromString($7->c_str()) );
	}

	%newobject op_extract_noexcept;
	extern statistics* op_extract_noexcept(user_interaction & dialog,
		archive *ptr,
		const path &fs_root,
		const archive_options_extract & options,
		statistics * progressive_report,
		U_16 & exception,
		std::string & except_msg);

	// ---------------------------------------------------- 

	%typemap(argout) (user_interaction & dialog,
			archive *ptr,
			const archive_options_listing & options,
			U_16 & exception,
			std::string & except_msg) {
		$result = PyList_New(2);
		PyList_SetItem($result, 0, PyInt_FromLong(*$4));
		PyList_SetItem($result, 1, PyUnicode_FromString($5->c_str()) );
	}

	extern void op_listing_noexcept(user_interaction & dialog,
		archive *ptr,
		const archive_options_listing & options,
		U_16 & exception,
		std::string & except_msg);

	// ---------------------------------------------------- 

	%typemap(argout) (user_interaction & dialog,
			archive *ptr,
			const path & fs_root,
			const archive_options_diff & options,
			statistics * progressive_report,
			U_16 & exception,
			std::string & except_msg) 
	{
		if ( *$6 != 0 )
		{
			EXCEPT_WRAP($6,$7)
		}

		libdar::close_statistics_noexcept(result, *$6, *$7);

		if ( *$6 != 0 ) {
			EXCEPT_WRAP($6,$7)
		}

		Py_XDECREF($result);
		$result = SWIG_Py_Void();
	}

	// %newobject op_diff_noexcept;
	extern statistics* op_diff_noexcept(user_interaction & dialog,
			archive *ptr,
			const path & fs_root,
			const archive_options_diff & options,
			statistics * progressive_report,
			U_16 & exception,
			std::string & except_msg);

	// // ---------------------------------------------------- 
	//     extern statistics op_test_noexcept(user_interaction & dialog,
	// 			       archive *ptr,
	// 			       const archive_options_test & options,
	// 			       statistics * progressive_report,
	// 			       U_16 & exception,
	// 			       std::string & except_msg);
	
	// // ---------------------------------------------------- 

	//     extern bool get_children_of_noexcept(user_interaction & dialog,
	// 				 archive *ptr,
	// 				 const std::string & dir,
	// 				 U_16 & exception,
	// 				 std::string & except_msg);


	%clear U_16& exception;
	%clear std::string& except_msg;
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

