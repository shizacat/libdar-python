//
// user_interaction.i - SWIG interface
//

%module user_interaction

%{
//	#include "../config.h"
	#include "user_interaction.hpp"
%}

%include "std_string.i"

%include "secu_string.i"


%{
	struct st_context_py_func {
		PyObject *f1, *f2, *f3, *f4;
		PyObject * context;
	};

	// python def x_warning_cb(str_warn, context_value)
	static void x_warning_callback(const std::string &x, void *context){
		st_context_py_func *ct = (st_context_py_func *) context;

		PyObject *func, *arglist;
		PyObject *result;

		func = (PyObject *) ct->f1;
		arglist = Py_BuildValue("(OO)", PyUnicode_FromString(x.c_str()), (PyObject *) ct->context);
                result = PyEval_CallObject(func, arglist);
		Py_DECREF(arglist);

		Py_XDECREF(result);
		return;
	};

	// python def x_answer_cb(str_warn, context_value)
	// return bool
	static bool x_answer_callback(const std::string &x, void *context){
		bool rc = false;

		st_context_py_func *ct = (st_context_py_func *) context;

		PyObject *func, *arglist;
		PyObject *result;

		func = (PyObject *) ct->f2;
		arglist = Py_BuildValue("(OO)", PyUnicode_FromString(x.c_str()), (PyObject *) ct->context);
		result = PyEval_CallObject(func, arglist);
		Py_DECREF(arglist);

		if ((result) && PyBool_Check(result) && ( result == Py_True )) {
			rc = true;
		}
		Py_XDECREF(result);

		return rc;
	};

	// python def x_string_cb(str, echo, context_value)
	// return string
	static std::string x_string_callback(const std::string &x, bool echo, void *context){
		st_context_py_func *ct = (st_context_py_func *) context;

		PyObject *func, *arglist;
		PyObject *result;

		func = (PyObject *) ct->f3;
		arglist = Py_BuildValue("(OOO)", PyUnicode_FromString(x.c_str()), PyBool_FromLong(echo), (PyObject *) ct->context);
		result = PyEval_CallObject(func, arglist);
		Py_DECREF(arglist);

		std::string rst = PyUnicode_AsUTF8(result);

		Py_XDECREF(result);

		return rst;
	};

	// python def x_string_cb(str, echo, context_value)
	// return string
	static libdar::secu_string x_secu_string_callback(const std::string &x, bool echo, void *context){
		st_context_py_func *ct = (st_context_py_func *) context;

		PyObject *func, *arglist;
		PyObject *result;

		func = (PyObject *) ct->f3;
		arglist = Py_BuildValue("(OOO)", PyUnicode_FromString(x.c_str()), PyBool_FromLong(echo), (PyObject *) ct->context);
		result = PyEval_CallObject(func, arglist);
		Py_DECREF(arglist);

		libdar::secu_string rst( PyUnicode_AsUTF8(result), strlen( PyUnicode_AsUTF8(result)) );

		Py_XDECREF(result);

		return rst;
	};
%}

namespace libdar {

	class user_interaction;

	%typemap(in) PyObject *pyfunc1, PyObject *pyfunc2, PyObject *pyfunc3, PyObject *pyfunc4 {
		if (!PyCallable_Check($input)) {
			PyErr_SetString(PyExc_TypeError, "Need a callable object!");
			return NULL;
		}
		$1 = $input;
	}

	// %newobject user_interaction_callback;
	%extend user_interaction_callback {
		user_interaction_callback(
			PyObject *pyfunc1, 
			PyObject *pyfunc2, 
			PyObject *pyfunc3, 
			PyObject *pyfunc4,
			PyObject *context_value)
		{
			st_context_py_func *context = new st_context_py_func;

			context->f1 = pyfunc1;
			context->f2 = pyfunc2;
			context->f3 = pyfunc3;
			context->f4 = pyfunc4;
			// context->context = NULL;
			context->context = context_value;

			return new libdar::user_interaction_callback(
				x_warning_callback,
				x_answer_callback,
				x_string_callback,
				x_secu_string_callback,
				(void *) context);
		};

		~user_interaction_callback(){
			// delete (st_context_py_func *) self->context_val;
			// !!! нужно получить доступ к private переменной
		}
	}
}

// %include "user_interaction.hpp"
namespace libdar {

	// %nodefaultdtor user_interaction_callback;

	class user_interaction_callback : public user_interaction
    {
    public:
		user_interaction_callback(void (*x_warning_callback)(const std::string &x, void *context),
				  bool (*x_answer_callback)(const std::string &x, void *context),
				  std::string (*x_string_callback)(const std::string &x, bool echo, void *context),
				  secu_string (*x_secu_string_callback)(const std::string &x, bool echo, void *context),
				  void *context_value);

		std::string get_string(const std::string & message, bool echo);
		    
		secu_string get_secu_string(const std::string & message, bool echo);
	};
}
