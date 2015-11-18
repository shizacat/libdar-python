//
// user_interaction.i - SWIG interface
//

%module user_interaction

%{
	#include "../config.h"
	#include "user_interaction.hpp"
%}

%include "std_string.i"

%include "secu_string.i"
// %include "infinint.i"


%{
	struct st_context_py_func {
		PyObject *f1, *f2, *f3, *f4;
		void * context;
	};

	// python def x_warning_cb(str_warn)
	static void x_warning_callback(const std::string &x, void *context){
		st_context_py_func *ct = (st_context_py_func *) context;

		PyObject *func, *arglist;
		PyObject *result;

		func = (PyObject *) ct->f1;
		//arglist = Py_BuildValue("(O)", PyUnicode_DecodeASCII(x.c_str(), strlen(x.c_str()), "strict") );
		arglist = Py_BuildValue("(O)", PyUnicode_FromString(x.c_str()));
                result = PyEval_CallObject(func, arglist);
		Py_DECREF(arglist);

		Py_XDECREF(result);
		return;
	};

	// python def x_answer_cb(str_warn)
	// return bool
	static bool x_answer_callback(const std::string &x, void *context){
		bool rc = false;

		st_context_py_func *ct = (st_context_py_func *) context;

		PyObject *func, *arglist;
		PyObject *result;

		func = (PyObject *) ct->f2;
		arglist = Py_BuildValue("(O)", PyUnicode_FromString(x.c_str()) );
		result = PyEval_CallObject(func, arglist);
		Py_DECREF(arglist);

		if ((result) && PyBool_Check(result) && ( result == Py_True )) {
			rc = true;
		}
		Py_XDECREF(result);

		return rc;
	};

	static std::string x_string_callback(const std::string &x, bool echo, void *context){
		return NULL;
	};

	static libdar::secu_string x_secu_string_callback(const std::string &x, bool echo, void *context){
		return NULL;
	};
%}

namespace libdar {

	class user_interaction;

	%typemap(python, in) PyObject *pyfunc1, PyObject *pyfunc2, PyObject *pyfunc3, PyObject *pyfunc4 {
		if (!PyCallable_Check($input)) {
			PyErr_SetString(PyExc_TypeError, "Need a callable object!");
			return NULL;
		}
		$1 = $input;
	}

	%extend user_interaction_callback {
		user_interaction_callback(
			PyObject *pyfunc1, 
			PyObject *pyfunc2, 
			PyObject *pyfunc3, 
			PyObject *pyfunc4)
			//void *context_value) - !!! нужно добавить что бы передавать аргументы из питона
		{
			st_context_py_func *context = new st_context_py_func;

			context->f1 = pyfunc1;
			context->f2 = pyfunc2;
			context->f3 = pyfunc3;
			context->f4 = pyfunc4;
			context->context = NULL;
			// context.context = context_value;

			return new libdar::user_interaction_callback(
				x_warning_callback,
				x_answer_callback,
				x_string_callback,
				x_secu_string_callback,
				(void *) context);
		};
	}
}

// %include "user_interaction.hpp"
namespace libdar {
	class user_interaction_callback : public user_interaction
    {
    public:
		user_interaction_callback(void (*x_warning_callback)(const std::string &x, void *context),
				  bool (*x_answer_callback)(const std::string &x, void *context),
				  std::string (*x_string_callback)(const std::string &x, bool echo, void *context),
				  secu_string (*x_secu_string_callback)(const std::string &x, bool echo, void *context),
				  void *context_value);


       	// void pause(const std::string & message);

		std::string get_string(const std::string & message, bool echo);
		    
		secu_string get_secu_string(const std::string & message, bool echo);
		    
	 //        void listing(const std::string & flag,
		// 	     const std::string & perm,
		// 	     const std::string & uid,
		// 	     const std::string & gid,
		// 	     const std::string & size,
		// 	     const std::string & date,
		// 	     const std::string & filename,
		// 	     bool is_dir,
		// 	     bool has_children);

		// void dar_manager_show_files(const std::string & filename,
		// 			    bool available_data,
		// 			    bool available_ea);

		// void dar_manager_contents(U_I number,
		// 			  const std::string & chemin,
		// 			  const std::string & archive_name);

		// void dar_manager_statistics(U_I number,
		// 			    const infinint & data_count,
		// 			    const infinint & total_data,
		// 			    const infinint & ea_count,
		// 			    const infinint & total_ea);

		// void dar_manager_show_version(U_I number,
		// 			      const std::string & data_date,
		// 			      const std::string & data_presence,
		// 			      const std::string & ea_date,
		// 			      const std::string & ea_presence);

	 //        void set_listing_callback(void (*callback)(const std::string & flag,
		// 					   const std::string & perm,
		// 					   const std::string & uid,
		// 					   const std::string & gid,
		// 					   const std::string & size,
		// 					   const std::string & date,
		// 					   const std::string & filename,
		// 					   bool is_dir,
		// 					   bool has_children,
		// 					   void *context));

		// void set_dar_manager_show_files_callback(void (*callback)(const std::string & filename,
		// 							  bool available_data,
		// 							  bool available_ea,
		// 							  void *context));

		// void set_dar_manager_contents_callback(void (*callback)(U_I number,
		// 							const std::string & chemin,
		// 							const std::string & archive_name,
		// 							void *context));

		// void set_dar_manager_statistics_callback(void (*callback)(U_I number,
		// 	const infinint & data_count,
		// 	const infinint & total_data,
		// 	const infinint & ea_count,
		// 	const infinint & total_ea,
		// 	void *context));

		// void set_dar_manager_show_version_callback(void (*callback)(U_I number,
		// 	const std::string & data_date,
		// 	const std::string & data_presence,
		// 	const std::string & ea_date,
		// 	const std::string & ea_presence,
		// 	void *context));
	};
}
