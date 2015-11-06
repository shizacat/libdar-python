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


%{
	struct st_context_py_func {
		PyObject *f1, *f2, *f3, *f4;
		void * context;
	};

	static void x_warning_callback(const std::string &x, void *context){
		st_context_py_func *ct = (st_context_py_func *) context;

		PyObject *func, *arglist;
		PyObject *result;

		func = (PyObject *) ct->f1;
		arglist = Py_BuildValue("(O)", PyUnicode_DecodeASCII(x.c_str(), strlen(x.c_str()), "strict") );
		result = PyEval_CallObject(func, arglist);
		Py_DECREF(arglist);

		Py_XDECREF(result);
		return;
	};

	static bool x_answer_callback(const std::string &x, void *context){
		bool rc = false;

		st_context_py_func *ct = (st_context_py_func *) context;

		PyObject *func, *arglist;
		PyObject *result;

		func = (PyObject *) ct->f2;
		arglist = Py_BuildValue("(O)", PyUnicode_DecodeASCII(x.c_str(), strlen(x.c_str()), "strict") );
		result = PyEval_CallObject(func, arglist);
		Py_DECREF(arglist);

		if ((result) && PyBool_Check(result) && ( result == Py_True )) {
			rc = true;
		}
		Py_XDECREF(result);

		return rc;
	};

	static std::string x_string_callback(const std::string &x, bool echo, void *context){

	};

	static libdar::secu_string x_secu_string_callback(const std::string &x, bool echo, void *context){

	};
%}

namespace libdar {

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
			st_context_py_func context;

			context.f1 = pyfunc1;
			context.f2 = pyfunc2;
			context.f3 = pyfunc3;
			context.f4 = pyfunc4;
			context.context = NULL;
			// context.context = context_value;

			return new libdar::user_interaction_callback(
				x_warning_callback,
				x_answer_callback,
				x_string_callback,
				x_secu_string_callback,
				(void *) &context);
		};
	}
}

%include "user_interaction.hpp"