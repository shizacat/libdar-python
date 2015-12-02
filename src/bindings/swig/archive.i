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
// archive.i - SWIG interface
//

%module archive

%{
	#include "dar/archive_options.hpp"
	#include "dar/archive.hpp"

	#include "dar/mask.hpp"
%}

%include "dar/mask.hpp"

%include "user_interaction.i"

// namespace libdar {
// 	class catalogue;
// 	class statistics;
// 	class fsa_scope;
// 	class entrepot;
// 	class hash_algo;
// }

// %include "archive_options.hpp"
// %include "archive.hpp"

namespace libdar {

	// class fsa_scope;
	// class entrepot;
	// class hash_algo;

	class archive;

	class archive_options_read : public on_pool
	{
	public:	
		archive_options_read();
		~archive_options_read();

		void set_crypto_pass(const secu_string & pass);
	};

	class archive_options_create : public on_pool
	{
	public:	
		archive_options_create();
		~archive_options_create();

		void set_reference(archive *ref_arch);
		void set_selection(const mask & selection);
		void set_subtree(const mask & subtree);
		void set_allow_over(bool allow_over);
		void set_warn_over(bool warn_over);
		void set_info_details(bool info_details);
		//void set_display_treated(bool display_treated, bool only_dir);
		void set_display_skipped(bool display_skipped);
		//void set_display_finished(bool display_finished);
		// // void set_pause(const infinint & pause);
		void set_empty_dir(bool empty_dir);
		void set_compression(compression compr_algo);
		void set_compression_level(U_I compression_level);
		// // void set_slicing(const infinint & file_size, const infinint & first_file_size);
		void set_ea_mask(const mask & ea_mask);
		void set_execute(const std::string & execute);
		// void set_crypto_algo(crypto_algo crypto);
		void set_crypto_pass(const secu_string & pass);
		void set_crypto_size(U_32 crypto_size);
		//void set_gnupg_recipients(const std::vector<std::string> & gnupg_recipients);
		//void set_gnupg_signatories(const std::vector<std::string> & gnupg_signatories);
		void set_compr_mask(const mask & compr_mask);
		// // void set_min_compr_size(const infinint & min_compr_size);
		void set_nodump(bool nodump);
		//void set_exclude_by_ea(const std::string & ea_name);
		// // void set_what_to_check(cat_inode::comparison_fields what_to_check);
		// // void set_hourshift(const infinint & hourshift);
		void set_empty(bool empty);
		void set_alter_atime(bool alter_atime);
		void set_furtive_read_mode(bool furtive_read);
		void set_same_fs(bool same_fs);
		void set_snapshot(bool snapshot);
		// void set_cache_directory_tagging(bool cache_directory_tagging);
		// // void set_fixed_date(const infinint & fixed_date);
		void set_slice_permission(const std::string & slice_permission);
		void set_slice_user_ownership(const std::string & slice_user_ownership);
		void set_slice_group_ownership(const std::string & slice_group_ownership);
		// // void set_retry_on_change(const infinint & count_max_per_file, const infinint & global_max_byte_overhead);
		void set_sequential_marks(bool sequential);
		// // void set_sparse_file_min_size(const infinint & size);
		void set_security_check(bool check);
		void set_user_comment(const std::string & comment);
		// void set_hash_algo(hash_algo hash);
		// // void set_slice_min_digits(infinint val);
		void set_backup_hook(const std::string & execute, const mask & which_files);
		void set_ignore_unknown_inode_type(bool val);
		// // void set_entrepot(const entrepot & entr);
		// // void set_fsa_scope(const fsa_scope & scope);
		//void set_multi_threaded(bool val);

		bool get_info_details() const;
		bool get_allow_over() const;
	};

	class archive_options_extract : public on_pool
	{
	public:	
		archive_options_extract();
		~archive_options_extract();
	};

	class archive_options_listing : public on_pool
    {
    public:
		archive_options_listing();
		~archive_options_listing();
	};

	class archive_options_diff : public on_pool
	{
	public:
		archive_options_diff();
		~archive_options_diff();
	};

	class archive_options_test : public on_pool
	{
	public:
		archive_options_test();
		~archive_options_test();
	};

	class archive_options_merge : public on_pool
    {
    public:
    	archive_options_merge();
    	archive_options_merge(const archive_options_merge & ref);
    	~archive_options_merge();
    };

	class archive : public on_pool{
	public:
		archive(user_interaction & dialog,
			const path & chem,
			const std::string & basename,
			const std::string & extension,
			const archive_options_read & options);

		void summary(user_interaction & dialog);
		void op_listing(user_interaction & dialog, const archive_options_listing & options);
	};
}